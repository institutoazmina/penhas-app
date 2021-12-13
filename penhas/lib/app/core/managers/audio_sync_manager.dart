import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/data/repositories/audio_sync_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

abstract class IAudioSyncManager {
  Future<String> audioFile({
    required String? session,
    required String sequence,
    String? suffix,
  });
  Future<bool> syncAudio();
  Future<Either<Failure, File>> cache(AudioEntity audio);
}

class AudioSyncManager implements IAudioSyncManager {
  Timer? _syncTimer;
  bool _syncAudioRunning = false;
  // ignore: unused_field
  late Timer _syncTimer;
  final _pendingUploadAudio = Queue<File>();
  final IAudioSyncRepository _audioRepository;

  AudioSyncManager({required IAudioSyncRepository audioRepository})
      : this._audioRepository = audioRepository {
    _init();
  }

  _init() async {
    await loadAudioQueue();
    setupUploadTimer();
  }

  @override
  Future<String> audioFile({
    required String? session,
    required String sequence,
    String? suffix,
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
      await loadAudioQueue();
      setupUploadTimer();
      syncAudios();

      return true;
    } catch (e, stack) {
      logError(e, stack);
      return true;
    }
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

  void setupUploadTimer() {
    // Why this block is commented?
    // if (_syncTimer != null) {
    //   return;
    // }

    // _syncTimer = Timer.periodic(
    //   Duration(seconds: 10),
    //   (timer) async {
    //     await loadAudioQueue();

    //     if (_pendingUploadAudio?.isEmpty ?? true) {
    //       timer.cancel();
    //       if (_syncTimer != null) {
    //         _syncTimer.cancel();
    //         _syncTimer = null;
    //       }
    //     }

    //     cleanCache();
    //     syncAudios();
    //   },
    // );
  }

  // ignore: unused_element
  Future<void> cleanCache() async {
    final DateTime purgeCacheTime =
        DateTime.now().subtract(const Duration(days: 3));

    final List<File> files = await getTemporaryDirectory()
        .then((dir) => dir.listSync(recursive: true))
        .then((value) => value.map((e) => File.fromUri(e.uri)).toList());

    files.retainWhere((f) => f.path.endsWith('.cached'));
    // se o último acesso for maior que o purgeCacheTime
    files.retainWhere(
      (f) => purgeCacheTime.compareTo(f.statSync().accessed) > 0,
    );
    files.map((e) => e.deleteSync());
  }

  Future<void> syncAudios() async {
    if (_syncAudioRunning || _pendingUploadAudio.isEmpty) {
      return;
    }

    _syncAudioRunning = true;
    setupUploadTimer();
    try {
      while (_pendingUploadAudio.isNotEmpty) {
        final file = _pendingUploadAudio.removeFirst();
        await _syncAudio(file);
      }
    } catch (e, stack) {
      logError(e, stack);
    }

    _pendingUploadAudio.retainWhere((e) => e.existsSync());
    _syncAudioRunning = false;
  }

  Future<void> _syncAudio(File file) async {
    try {
      if (file.statSync().size < 30) {
        file.deleteSync();
        return;
      }

      final fileName = file.name;
      final parts = fileName.split(RegExp('[_.]'));
      final audio = AudioData(
        media: file,
        eventId: parts[1],
        sequence: parts[2],
        createdAt: mapEpochToUTC(parts[0]),
      );

      final result = await _audioRepository.upload(audio);
      result.fold(
        (l) => handleUploadFailure(l, file),
        (r) => file.deleteSync(),
      );
    } catch (e, stack) {
      logError(e, stack);
    }

    return Future.value();
  }

  void handleUploadFailure(Failure failure, File file) {
    logError(failure);
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

  Future<void> loadAudioQueue() async {
    final dirs = await dirAudioUploadContent();
    dirs.forEach((file) {
      var status = _pendingUploadAudio.firstWhereOrNull(
        (e) => e.path == file.path,
      );

      if (status == null) {
        _pendingUploadAudio.add(file);
      }
    }
  }
}

extension _FileExtention on File {
  String get name {
    return path.split(Platform.pathSeparator).last;
  }
}
