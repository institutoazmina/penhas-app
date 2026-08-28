import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../features/help_center/data/repositories/audio_sync_repository.dart';
import '../../features/help_center/domain/entities/audio_entity.dart';
import '../../shared/logger/log.dart';
import '../error/failures.dart';
import '../network/api_server_configure.dart';

abstract class IAudioSyncManager {
  Future<String> audioFile({
    required String? session,
    required String sequence,
    String suffix,
  });
  Future<bool> syncAudio();
  Future<Either<Failure, File>> cache(AudioEntity audio);
  Future<List<Map<String, String>>> pendingUploads();

  /// Broadcast re-emit of `FileDownloader().updates`. The manager owns the
  /// single subscription to that single-subscription stream; consumers (e.g.
  /// AudiosController) listen here instead of subscribing to FileDownloader
  /// directly — a second direct subscription throws "Stream has already been
  /// listened to".
  Stream<TaskUpdate> get updates;
  void dispose();
}

class AudioSyncManager implements IAudioSyncManager {
  AudioSyncManager({
    required IAudioSyncRepository audioRepository,
    required IApiServerConfigure serverConfiguration,
    FileDownloader? downloader,
    @visibleForTesting bool? waitForDownloaderStartup,
  })  : _audioRepository = audioRepository,
        _serverConfiguration = serverConfiguration,
        _downloader = downloader ?? FileDownloader(),
        _waitForDownloaderStartup =
            waitForDownloaderStartup ?? downloader == null {
    _updatesOwner = this;
    _listenToDownloaderUpdates();
    _init();
  }

  static const audioUploadGroup = 'penhas-audio-upload';
  static const audioUploadEndpointPath = '/me/audios';
  static final RegExp _uuidV4Pattern = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  );

  final IAudioSyncRepository _audioRepository;
  final IApiServerConfigure _serverConfiguration;
  final FileDownloader _downloader;
  final bool _waitForDownloaderStartup;
  final StreamController<TaskUpdate> _updatesController =
      StreamController<TaskUpdate>.broadcast();

  // FileDownloader.updates is a single-subscription stream. Install its
  // listener before FileDownloader.start() (from main.dart), while the
  // manager itself is created later by the authenticated app module.
  static StreamSubscription<TaskUpdate>? _downloaderUpdatesSubscription;
  static AudioSyncManager? _updatesOwner;
  static final List<TaskUpdate> _updatesBeforeManager = <TaskUpdate>[];
  static Completer<bool>? _downloaderStartupCompleter;

  // Startup, recording, and lifecycle callbacks can all request a scan at
  // once. Keep scans in one FIFO chain.
  Future<void> _syncTail = Future<void>.value();
  final Set<String> _pendingTaskIds = <String>{};

  /// Installs the downloader listener before [FileDownloader.start].
  ///
  /// It is safe to call more than once. Updates received before the
  /// authenticated manager exists are retained until its constructor attaches
  /// the update handler.
  static void prepareForDownloaderStart() {
    _downloaderStartupCompleter ??= Completer<bool>();
    _listenToDownloaderUpdates();
  }

  /// Marks tracking and killed-task rescheduling as complete. Recovery waits
  /// for this signal, but the caller can still initialize it fire-and-forget.
  static void markDownloaderStartupComplete() {
    final completer = _downloaderStartupCompleter;
    if (completer != null && !completer.isCompleted) {
      completer.complete(true);
    }
  }

  /// Marks startup as failed without leaving recovery callers waiting forever.
  static void markDownloaderStartupFailed() {
    final completer = _downloaderStartupCompleter;
    if (completer != null && !completer.isCompleted) {
      completer.complete(false);
    }
  }

  static Future<bool> get _downloaderReady =>
      _downloaderStartupCompleter?.future ?? Future<bool>.value(true);

  static void _listenToDownloaderUpdates() {
    if (_downloaderUpdatesSubscription != null) return;

    _downloaderUpdatesSubscription = FileDownloader().updates.listen((update) {
      if (!_isAudioUploadTask(update.task)) return;

      final manager = _updatesOwner;
      if (manager == null) {
        _updatesBeforeManager.add(update);
      } else {
        manager._handleUpdate(update);
      }
    });
  }

  @override
  Stream<TaskUpdate> get updates => _updatesController.stream;

  @visibleForTesting
  void handleUpdateForTesting(TaskUpdate update) {
    _handleUpdate(update);
  }

  void _init() {
    final pendingUpdates = List<TaskUpdate>.from(_updatesBeforeManager);
    _updatesBeforeManager.clear();
    for (final update in pendingUpdates) {
      _handleUpdate(update);
    }
  }

  void _handleUpdate(TaskUpdate update) {
    if (!_isRecognizedAudioUploadTask(update.task)) return;

    // Re-broadcast every update so multiple consumers can react.
    if (!_updatesController.isClosed) {
      _updatesController.add(update);
    }

    if (update is! TaskStatusUpdate) return;

    if (update.status == TaskStatus.complete) {
      // Only a complete update authorizes deleting this task's exact file.
      // Never scan/delete files in response to a failure.
      final cleanup = _deleteCompletedTaskFile(update.task);
      unawaited(cleanup.whenComplete(
        () => _pendingTaskIds.remove(update.task.taskId),
      ));
    } else if (update.status == TaskStatus.failed) {
      _pendingTaskIds.remove(update.task.taskId);
      logError('Upload failed: ${update.task.taskId} - ${update.task.url}');
    } else if (update.status == TaskStatus.canceled ||
        update.status == TaskStatus.notFound) {
      _pendingTaskIds.remove(update.task.taskId);
    }
  }

  Future<void> _deleteCompletedTaskFile(Task task) async {
    try {
      final file = File(await task.filePath());
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stack) {
      // If cleanup fails, preserve the audio rather than losing it.
      logError(e, stack);
    }
  }

  Future<void> _migrateOrphanFiles(String apiToken) async {
    final files = await dirAudioUploadContent();
    for (final file in files) {
      try {
        await _recoverFile(file, apiToken);
      } catch (e, stack) {
        // Keep scanning the remaining candidates if one file or database
        // operation fails. The file is intentionally left untouched.
        logError(e, stack);
      }
    }
  }

  Future<void> _recoverFile(File file, String apiToken) async {
    final candidate = await _candidateFor(file);
    if (candidate == null) return;

    final taskId = candidate.filename;
    final record = await _downloader.database.recordForId(taskId);
    if (record != null) {
      if (!_isRecognizedAudioUploadTask(record.task)) return;

      const activeStatuses = <TaskStatus>{
        TaskStatus.enqueued,
        TaskStatus.running,
        TaskStatus.waitingToRetry,
        TaskStatus.paused,
      };
      if (activeStatuses.contains(record.status)) return;

      if (record.status == TaskStatus.complete) {
        await _deleteCompletedTaskFile(record.task);
        return;
      }

      // Remove a terminal record before retrying it. The file stays until a
      // later complete update is received, including for canceled uploads.
      await _downloader.database.deleteRecordWithId(taskId);
    } else if (_pendingTaskIds.contains(taskId)) {
      // FileDownloader may emit the enqueued update before its asynchronous
      // database write is visible. Avoid a duplicate in that small window.
      return;
    }

    if (await _hasNativePendingTask(taskId)) return;

    // Claim the task before enqueueing. The downloader can emit an update and
    // a second lifecycle callback can start before enqueue() returns.
    _pendingTaskIds.add(taskId);
    try {
      final enqueued = await _enqueueFile(file, candidate, apiToken);
      if (!enqueued) {
        _pendingTaskIds.remove(taskId);
      }
    } catch (_) {
      _pendingTaskIds.remove(taskId);
      rethrow;
    }
  }

  Future<_AudioCandidate?> _candidateFor(File file) async {
    try {
      if (p.extension(file.path) != '.aac') return null;

      final stat = await file.stat();
      if (stat.type != FileSystemEntityType.file || stat.size < 30) {
        return null;
      }

      final filename = p.basename(file.path);
      return _candidateFromFilename(filename);
    } catch (e, stack) {
      logError(e, stack);
      return null;
    }
  }

  Future<bool> _enqueueFile(
    File file,
    _AudioCandidate candidate,
    String apiToken,
  ) async {
    if (apiToken.trim().isEmpty) return false;

    final createdAt = mapEpochToUTC(candidate.epoch);
    final fileSha1 = sha1.convert(await file.readAsBytes()).toString();
    final (baseDirectory, directory, filename) = await Task.split(file: file);
    if (baseDirectory != BaseDirectory.applicationDocuments ||
        filename != candidate.filename) {
      return false;
    }

    final baseUri = _serverConfiguration.baseUri;
    final userAgent = await _serverConfiguration.userAgent;

    final task = UploadTask(
      taskId: candidate.filename,
      filename: filename,
      directory: directory,
      baseDirectory: baseDirectory,
      url: baseUri.replace(path: audioUploadEndpointPath).toString(),
      group: audioUploadGroup,
      fileField: 'media',
      httpRequestMethod: 'POST',
      fields: {
        'sha1': fileSha1,
        'event_id': candidate.eventId,
        'event_sequence': candidate.sequence,
        'cliente_created_at': createdAt,
        'current_time': DateTime.now().toUtc().toIso8601String(),
      },
      headers: {
        'X-Api-Key': apiToken,
        'User-Agent': userAgent,
      },
      updates: Updates.statusAndProgress,
      retries: 5,
      requiresWiFi: false,
    );

    final enqueued = await _downloader.enqueue(task);
    if (!enqueued) {
      logError('Could not enqueue audio upload: ${task.taskId}');
    }
    return enqueued;
  }

  @override
  Future<String> audioFile({
    required String? session,
    required String sequence,
    String suffix = '.aac',
  }) async {
    if (session == null || !_uuidV4Pattern.hasMatch(session)) {
      throw ArgumentError.value(session, 'session', 'must be a UUID v4');
    }

    final sequenceValue = int.tryParse(sequence);
    if (sequenceValue == null || sequenceValue < 0 || sequenceValue > 1000) {
      throw ArgumentError.value(
        sequence,
        'sequence',
        'must be an integer between 0 and 1000',
      );
    }

    var extension = suffix.toLowerCase();
    if (!extension.startsWith('.')) extension = '.$extension';
    if (extension != '.aac') {
      throw ArgumentError.value(suffix, 'suffix', 'must be .aac');
    }

    final prefix = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName =
        '${prefix}_${session.toLowerCase()}_${sequenceValue.toString()}$extension';
    final path = await getApplicationDocumentsDirectory()
        .then((dir) => p.join(dir.path, fileName));
    final directory = p.dirname(path);
    Directory(directory).createSync(recursive: true);

    return path;
  }

  @override
  Future<bool> syncAudio() async {
    final operation = _syncTail.then<void>((_) async {
      try {
        var apiToken = await _serverConfiguration.apiToken;
        if (apiToken == null || apiToken.trim().isEmpty) return;

        if (_waitForDownloaderStartup) {
          final startupSucceeded = await _downloaderReady;
          if (!startupSucceeded) return;
        }

        apiToken = await _serverConfiguration.apiToken;
        if (apiToken == null || apiToken.trim().isEmpty) return;

        await _migrateOrphanFiles(apiToken);
      } catch (e, stack) {
        logError(e, stack);
      }
    });
    _syncTail = operation;
    await operation;
    return true;
  }

  @override
  Future<List<Map<String, String>>> pendingUploads() async {
    try {
      final records = await _downloader.database.allRecords();
      return records
          .where((r) =>
              _isRecognizedAudioUploadTask(r.task) &&
              (r.status == TaskStatus.enqueued ||
                  r.status == TaskStatus.running))
          .map((r) => {
                'taskId': r.taskId,
                'status': r.status.name,
                'progress': (r.progress * 100).toStringAsFixed(0),
              })
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  void dispose() {
    if (identical(_updatesOwner, this)) {
      _updatesOwner = null;
    }
    _updatesController.close();
  }

  @override
  Future<Either<Failure, File>> cache(AudioEntity audio) async {
    final File file = await cacheFile(audio);
    const int emptyFileSize = 100;

    try {
      if (file.lengthSync() > emptyFileSize) {
        return right(file);
      }

      final result = await _audioRepository.download(audio, file);
      return result.fold<Either<Failure, File>>(
        (l) => left(l),
        (r) => right(file),
      );
    } catch (e, stack) {
      logError(e, stack);
      file.deleteSync();
      return left(FileSystemFailure());
    }
  }

  String mapEpochToUTC(String time) {
    int epoch;
    try {
      epoch = int.parse(time);
    } catch (e, stack) {
      logError(e, stack);
      epoch = DateTime.now()
          .toUtc()
          .subtract(const Duration(minutes: 1))
          .millisecondsSinceEpoch;
    }

    return DateTime.fromMillisecondsSinceEpoch(epoch).toUtc().toIso8601String();
  }

  Future<List<File>> dirAudioUploadContent() async {
    final entities = await getApplicationDocumentsDirectory()
        .then((dir) => dir.listSync(recursive: true, followLinks: false));
    final files = entities
        .whereType<File>()
        .where((file) => p.extension(file.path) == '.aac')
        .toList();
    files.sort((a, b) => a.path.compareTo(b.path));
    return files;
  }

  static bool _isAudioUploadTask(Task task) {
    if (task is! UploadTask) return false;
    if (Uri.tryParse(task.url)?.path != audioUploadEndpointPath) return false;

    return task.group == audioUploadGroup ||
        (task.group == FileDownloader.defaultGroup &&
            _hasExpectedAudioFields(task));
  }

  static bool _isRecognizedAudioUploadTask(Task task) {
    return _isAudioUploadTask(task) &&
        _candidateFromFilename(task.filename) != null;
  }

  static bool _hasExpectedAudioFields(UploadTask task) {
    const expectedFields = <String>{
      'sha1',
      'event_id',
      'event_sequence',
      'cliente_created_at',
      'current_time',
    };
    final candidate = _candidateFromFilename(task.filename);
    if (candidate == null ||
        task.fileField != 'media' ||
        task.fields.length != expectedFields.length ||
        !task.fields.keys.toSet().containsAll(expectedFields)) {
      return false;
    }

    final sha1Value = task.fields['sha1']!;
    if (!RegExp(r'^[0-9a-fA-F]{40}$').hasMatch(sha1Value)) return false;
    if (task.fields['event_id'] != candidate.eventId ||
        task.fields['event_sequence'] != candidate.sequence) {
      return false;
    }
    if (DateTime.tryParse(task.fields['cliente_created_at']!) == null) {
      return false;
    }
    if (DateTime.tryParse(task.fields['current_time']!) == null) return false;
    return true;
  }

  Future<bool> _hasNativePendingTask(String taskId) async {
    try {
      final nativeTasks = await _downloader.allTasks(
        allGroups: true,
        includeTasksWaitingToRetry: true,
      );
      return nativeTasks.any((task) => task.taskId == taskId);
    } catch (e, stack) {
      // Fail closed: an unavailable native queue must not cause a duplicate
      // enqueue. The next authenticated recovery can try again.
      logError(e, stack);
      return true;
    }
  }

  static _AudioCandidate? _candidateFromFilename(String filename) {
    if (p.extension(filename) != '.aac' || p.basename(filename) != filename) {
      return null;
    }

    final parts = p.basenameWithoutExtension(filename).split('_');
    if (parts.length != 3 || parts.any((part) => part.isEmpty)) {
      return null;
    }

    final epoch = int.tryParse(parts[0]);
    final earliestPlausibleEpoch = DateTime.utc(2000).millisecondsSinceEpoch;
    final latestPlausibleEpoch = DateTime.now()
        .toUtc()
        .add(const Duration(days: 1))
        .millisecondsSinceEpoch;
    if (epoch == null ||
        epoch < earliestPlausibleEpoch ||
        epoch > latestPlausibleEpoch) {
      return null;
    }

    if (!_uuidV4Pattern.hasMatch(parts[1])) return null;

    final sequence = int.tryParse(parts[2]);
    if (sequence == null ||
        sequence < 0 ||
        sequence > 1000 ||
        sequence.toString() != parts[2]) {
      return null;
    }

    return _AudioCandidate(
      filename: filename,
      epoch: parts[0],
      eventId: parts[1],
      sequence: parts[2],
    );
  }
}

class _AudioCandidate {
  const _AudioCandidate({
    required this.filename,
    required this.epoch,
    required this.eventId,
    required this.sequence,
  });

  final String filename;
  final String epoch;
  final String eventId;
  final String sequence;
}

extension _AudioSyncManager on AudioSyncManager {
  Future<File> cacheFile(AudioEntity audio) async {
    final fileName = [audio.id, 'cached'].join('.');
    final path =
        await getTemporaryDirectory().then((dir) => p.join(dir.path, fileName));

    final file = File(path);

    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }
}
