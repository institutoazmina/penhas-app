import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penhas/app/features/help_center/data/repositories/audio_sync_repository.dart';

abstract class IAudioSyncManager {
  Future<String> audioFile({@required String session, String suffix});
  Future<bool> syncAudio(String path);
}

class AudioSyncManager implements IAudioSyncManager {
  List<File> _pendingUploadAudio = List<File>();
  bool _syncAudioRunning = false;
  Timer _syncTimer;

  final IAudioSyncRepository _audioRepository;

  AudioSyncManager({@required IAudioSyncRepository audioRepository})
      : this._audioRepository = audioRepository {
    _init();
  }

  _init() async {
    _setupUploadTimer();
    _pendingUploadAudio = await _dirContent();
  }

  Future<List<File>> _dirContent() async {
    List<File> files = await getApplicationDocumentsDirectory()
        .then((dir) => dir.listSync(recursive: true))
        .then((value) => value.map((e) => File.fromUri(e.uri)).toList());

    files.retainWhere((f) => f.path.endsWith('.aac'));
    files.sort((a, b) => a.path.compareTo(b.path));
    return files;
  }

  @override
  Future<String> audioFile({@required String session, String suffix}) async {
    suffix ??= '.aac';
    if (!suffix.startsWith('.')) {
      suffix = '.$suffix';
    }

    final prefix = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName = '${prefix}_${session}_$suffix';
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
      if (_pendingUploadAudio == null) {
        _pendingUploadAudio = [file];
      } else {
        _pendingUploadAudio.add(file);
      }

      _setupUploadTimer();
      _syncAudios();

      return true;
    } catch (e) {
      return true;
    }
  }

  void _syncAudios() async {
    if (_syncAudioRunning) {
      return;
    }

    _syncAudioRunning = true;
    _setupUploadTimer();

    _pendingUploadAudio.forEach((file) async => await _syncAudio(file));
    _pendingUploadAudio.retainWhere((e) => e.existsSync());
    if (_pendingUploadAudio?.isEmpty ?? true) {
      _pendingUploadAudio = await _dirContent();
    }
  }

  Future<void> _syncAudio(File file) async {
    try {
      final fileName = file.name;
      final parts = fileName.split('_');
      final audio = AudioData(
        media: file,
        eventId: parts[1],
        createdAt: parts[0],
      );

      final result = await _audioRepository.upload(audio);
      result.fold(
        (l) {
          print(l);
        },
        (r) => file.deleteSync(),
      );
    } catch (e) {}
  }

  void _setupUploadTimer() {
    if (_syncTimer != null) {
      return;
    }

    _syncTimer = Timer.periodic(
      Duration(seconds: 10),
      (timer) {
        if (_pendingUploadAudio.length == 0) {
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
