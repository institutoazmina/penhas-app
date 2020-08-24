import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/data/repositories/audio_sync_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

abstract class IAudioSyncManager {
  Future<String> audioFile({
    @required String session,
    @required String sequence,
    String suffix,
  });
  Future<bool> syncAudio();
  Future<Either<Failure, File>> cache(AudioEntity audio);
}

class AudioSyncManager implements IAudioSyncManager {
  Timer _syncTimer;
  bool _syncAudioRunning = false;
  final _pendingUploadAudio = Queue<File>();
  final IAudioSyncRepository _audioRepository;

  AudioSyncManager({@required IAudioSyncRepository audioRepository})
      : this._audioRepository = audioRepository {
    _init();
  }

  _init() async {
    await loadAudioQueue();
    setupUploadTimer();
  }

  @override
  Future<String> audioFile({
    @required String session,
    @required String sequence,
    String suffix,
  }) async {
    suffix ??= '.aac';
    if (!suffix.startsWith('.')) {
      suffix = '.$suffix';
    }

    final prefix = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName = '${prefix}_${session}_${sequence}_$suffix';
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
    } catch (e) {
      return true;
    }
  }

  @override
  Future<Either<Failure, File>> cache(AudioEntity audio) async {
    File file = await cacheFile(audio);
    int emptyFileSize = 100;

    try {
      if (file.lengthSync() > emptyFileSize) {
        return right(file);
      }

      final result = await _audioRepository.download(audio, file);
      return result.fold<Either<Failure, File>>(
        (l) => left(l),
        (r) => right(file),
      );
    } catch (e) {
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
    if (_syncTimer != null) {
      return;
    }

    _syncTimer = Timer.periodic(
      Duration(seconds: 10),
      (timer) async {
        await loadAudioQueue();

        if (_pendingUploadAudio?.isEmpty ?? true) {
          timer.cancel();
          _syncTimer.cancel();
          _syncTimer = null;
        }

        cleanCache();
        syncAudios();
      },
    );
  }

  void cleanCache() async {
    DateTime purgeCacheTime = DateTime.now().subtract(Duration(days: 3));

    List<File> files = await getTemporaryDirectory()
        .then((dir) => dir.listSync(recursive: true))
        .then((value) => value.map((e) => File.fromUri(e.uri)).toList());

    files.retainWhere((f) => f.path.endsWith('.cached'));
    // se o último acesso for maior que o purgeCacheTime
    files.retainWhere(
        (f) => purgeCacheTime.compareTo(f.statSync().accessed) > 0);
    files.map((e) => e.deleteSync());
  }

  void syncAudios() async {
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
    } catch (e) {}

    _pendingUploadAudio.retainWhere((e) => e.existsSync());
    _syncAudioRunning = false;
  }

  Future<void> _syncAudio(File file) async {
    try {
      final fileName = file.name;
      final parts = fileName.split('_');
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
    } catch (e) {}

    return Future.value();
  }

  void handleUploadFailure(Failure failure, File file) {
    print(failure);
    if (file.existsSync()) {
      Future.delayed(Duration(seconds: 30), () {
        _pendingUploadAudio.addLast(file);
        setupUploadTimer();
      });
    }
  }

  String mapEpochToUTC(String time) {
    int epoch;
    try {
      epoch = int.parse(time);
    } catch (e) {
      epoch = DateTime.now()
          .toUtc()
          .subtract(Duration(minutes: 1))
          .millisecondsSinceEpoch;
    }

    return DateTime.fromMillisecondsSinceEpoch(epoch).toUtc().toIso8601String();
  }

  Future<List<File>> dirAudioUploadContent() async {
    List<File> files = await getApplicationDocumentsDirectory()
        .then((dir) => dir.listSync(recursive: true))
        .then((value) => value.map((e) => File.fromUri(e.uri)).toList());

    files.retainWhere((f) => f.path.endsWith('.aac'));
    files.sort((a, b) => a.path.compareTo(b.path));
    return files;
  }

  Future<void> loadAudioQueue() async {
    final dirs = await dirAudioUploadContent();
    dirs.forEach((file) {
      var status = _pendingUploadAudio.firstWhere(
        (e) => e.path == file.path,
        orElse: () => null,
      );

      if (status == null) {
        _pendingUploadAudio.add(file);
      }
    });

    return Future.value();
  }
}

extension _FileExtention on File {
  String get name {
    return this?.path?.split(Platform.pathSeparator)?.last;
  }
}
