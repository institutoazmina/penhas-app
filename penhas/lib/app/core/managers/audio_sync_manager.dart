import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract class IAudioSyncManager {
  Future<String> audioFile({String suffix});
  Future<bool> syncAudio(String path);
}

class AudioSyncManager implements IAudioSyncManager {
  List<File> _pendingUploadAudio = List<File>();
  bool _syncAudioRunning = false;
  Timer _syncTimer;

  AudioSyncManager() {
    _init();
  }

  _init() async {
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

    _pendingUploadAudio = await _dirContent();
  }

  Future<List<File>> _dirContent() async {
    List<File> files = await getApplicationDocumentsDirectory()
        .then((dir) => dir.listSync(recursive: true))
        .then((value) => value.map((e) => File.fromUri(e.uri)).toList());

    files.retainWhere((f) => f.path.endsWith('.aac'));
    files.sort((a, b) => a.path.compareTo(b.path));
    print(files);
    print(files.length);
    return files;
  }

  @override
  Future<String> audioFile({String suffix}) async {
    suffix ??= '.aac';
    if (!suffix.startsWith('.')) {
      suffix = '.$suffix';
    }

    final prefix = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName = '${prefix}_${Uuid().v4()}$suffix';
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

      if (file == null) return false;
      if (_pendingUploadAudio == null) {
        _pendingUploadAudio = [file];
      } else {
        _pendingUploadAudio.add(file);
      }

      if (_syncTimer == null) {
        // carrega o 'daemon' para executar esta tarefa
      }

      return true;
    } catch (e) {
      return true;
    }
  }

  void _syncAudios() async {
    if (_syncAudioRunning) {
      return;
    }

    // _syncAudioRunning = true;
    int finalRange =
        _pendingUploadAudio.length > 10 ? 10 : _pendingUploadAudio.length;
    _pendingUploadAudio.removeRange(0, finalRange);
  }
}
