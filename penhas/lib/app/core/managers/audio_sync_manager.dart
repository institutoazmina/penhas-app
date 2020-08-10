import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract class IAudioSyncManager {
  Future<String> audioFile({String suffix});
}

class AudioSyncManager implements IAudioSyncManager {
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
}
