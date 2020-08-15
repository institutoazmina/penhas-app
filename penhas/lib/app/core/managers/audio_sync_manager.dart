import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/data/repositories/audio_sync_repository.dart';

abstract class IAudioSyncManager {
  Future<String> audioFile({
    @required String session,
    @required String sequence,
    String suffix,
  });
  Future<bool> syncAudio(String path);
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
    await _loadAudioQueue();
    _setupUploadTimer();
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
  Future<bool> syncAudio(String path) async {
    try {
      final file = File(path);

      if (file == null || file.existsSync() == false) return false;
      _pendingUploadAudio.addLast(file);

      _setupUploadTimer();
      _syncAudios();

      return true;
    } catch (e) {
      return true;
    }
  }

  Future<List<File>> _dirContent() async {
    List<File> files = await getApplicationDocumentsDirectory()
        .then((dir) => dir.listSync(recursive: true))
        .then((value) => value.map((e) => File.fromUri(e.uri)).toList());

    files.retainWhere((f) => f.path.endsWith('.aac'));
    files.sort((a, b) => a.path.compareTo(b.path));
    return files;
  }

  Future<void> _loadAudioQueue() async {
    if (_pendingUploadAudio.isEmpty) {
      final dirs = await _dirContent();
      _pendingUploadAudio.addAll(dirs);
    }

    return Future.value();
  }

  Future<void> _syncAudio(File file) async {
    try {
      final fileName = file.name;
      final parts = fileName.split('_');
      final audio = AudioData(
        media: file,
        eventId: parts[1],
        sequence: parts[2],
        createdAt: _mapEpochToUTC(parts[0]),
      );

      final result = await _audioRepository.upload(audio);
      result.fold(
        (l) => _handleUploadFailure(l, file),
        (r) => file.deleteSync(),
      );
    } catch (e) {}

    return Future.value();
  }

  void _handleUploadFailure(Failure failure, File file) {
    print(failure);
    if (file.existsSync()) {
      Future.delayed(Duration(seconds: 30), () {
        _pendingUploadAudio.addLast(file);
        _setupUploadTimer();
      });
    }
  }

  String _mapEpochToUTC(String time) {
    int epoch;
    try {
      epoch = int.parse(time);
    } catch (e) {
      epoch =
          DateTime.now().subtract(Duration(minutes: 1)).millisecondsSinceEpoch;
    }

    return DateTime.fromMillisecondsSinceEpoch(epoch).toUtc().toIso8601String();
  }

  void _syncAudios() async {
    if (_syncAudioRunning || _pendingUploadAudio.isEmpty) {
      return;
    }

    _syncAudioRunning = true;
    _setupUploadTimer();
    try {
      while (_pendingUploadAudio.isNotEmpty) {
        final file = _pendingUploadAudio.removeFirst();
        await _syncAudio(file);
      }
    } catch (e) {}

    _pendingUploadAudio.retainWhere((e) => e.existsSync());
    _syncAudioRunning = false;
  }

  void _setupUploadTimer() {
    if (_syncTimer != null) {
      return;
    }

    _syncTimer = Timer.periodic(
      Duration(seconds: 10),
      (timer) {
        if (_pendingUploadAudio?.isEmpty ?? true) {
          timer.cancel();
          _syncTimer.cancel();
          _syncTimer = null;
        }

        _syncAudios();
      },
    );
  }
}

extension _FileExtention on File {
  String get name {
    return this?.path?.split(Platform.pathSeparator)?.last;
  }
}
