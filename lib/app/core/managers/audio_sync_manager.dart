import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
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
  })  : _audioRepository = audioRepository,
        _serverConfiguration = serverConfiguration {
    _init();
  }

  final IAudioSyncRepository _audioRepository;
  final IApiServerConfigure _serverConfiguration;
  StreamSubscription<TaskUpdate>? _updatesSubscription;
  final StreamController<TaskUpdate> _updatesController =
      StreamController<TaskUpdate>.broadcast();

  @override
  Stream<TaskUpdate> get updates => _updatesController.stream;

  Future _init() async {
    _updatesSubscription = FileDownloader().updates.listen(_handleUpdate);
    await _migrateOrphanFiles();
  }

  void _handleUpdate(TaskUpdate update) {
    // Re-broadcast every update so multiple consumers can react.
    if (!_updatesController.isClosed) {
      _updatesController.add(update);
    }
    if (update is TaskStatusUpdate && update.status == TaskStatus.complete) {
      update.task.filePath().then((path) {
        final file = File(path);
        if (file.existsSync()) {
          file.deleteSync();
        }
      });
    }
    if (update is TaskStatusUpdate && update.status == TaskStatus.failed) {
      logError('Upload failed: ${update.task.taskId} - ${update.task.url}');
    }
  }

  Future<void> _migrateOrphanFiles() async {
    final files = await dirAudioUploadContent();
    for (final file in files) {
      await _enqueueFile(file);
    }
  }

  Future<void> _enqueueFile(File file) async {
    if (file.statSync().size < 30) {
      file.deleteSync();
      return;
    }

    final fileName = file.name;
    final parts = fileName.split(RegExp('[_.]'));
    if (parts.length < 3) return;

    final epoch = parts[0];
    final eventId = parts[1];
    final sequence = parts[2];
    final createdAt = mapEpochToUTC(epoch);
    final fileSha1 = sha1.convert(file.readAsBytesSync()).toString();
    final baseUri = _serverConfiguration.baseUri;
    final apiToken = await _serverConfiguration.apiToken ?? '';
    final userAgent = await _serverConfiguration.userAgent;

    final task = UploadTask.fromFile(
      file: file,
      taskId: fileName,
      url: baseUri.replace(path: '/me/audios').toString(),
      fileField: 'media',
      httpRequestMethod: 'POST',
      fields: {
        'sha1': fileSha1,
        'event_id': eventId,
        'event_sequence': sequence,
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

    await FileDownloader().enqueue(task);
  }

  @override
  Future<String> audioFile({
    required String? session,
    required String sequence,
    String suffix = '.aac',
  }) async {
    String extension = suffix;
    if (!extension.startsWith('.')) {
      extension = '.$extension';
    }

    final prefix = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName = '${prefix}_${session}_$sequence$extension';
    final path = await getApplicationDocumentsDirectory()
        .then((dir) => join(dir.path, fileName));
    final directory = dirname(path);
    Directory(directory).createSync(recursive: true);

    return path;
  }

  @override
  Future<bool> syncAudio() async {
    try {
      final files = await dirAudioUploadContent();
      for (final file in files) {
        await _enqueueFile(file);
      }
      return true;
    } catch (e, stack) {
      logError(e, stack);
      return true;
    }
  }

  @override
  Future<List<Map<String, String>>> pendingUploads() async {
    try {
      final records = await FileDownloader().database.allRecords();
      return records
          .where((r) =>
              r.status == TaskStatus.enqueued ||
              r.status == TaskStatus.running)
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
    _updatesSubscription?.cancel();
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
    final List<File> files = await getApplicationDocumentsDirectory()
        .then((dir) => dir.listSync(recursive: true))
        .then((value) => value.map((e) => File.fromUri(e.uri)).toList());

    files.retainWhere((f) => f.path.endsWith('.aac'));
    files.sort((a, b) => a.path.compareTo(b.path));
    return files;
  }
}

extension _FileExtension on File {
  String get name {
    return path.split(Platform.pathSeparator).last;
  }
}

extension _AudioSyncManager on AudioSyncManager {
  Future<File> cacheFile(AudioEntity audio) async {
    final fileName = [audio.id, 'cached'].join('.');
    final path =
        await getTemporaryDirectory().then((dir) => join(dir.path, fileName));

    final file = File(path);

    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }
}
