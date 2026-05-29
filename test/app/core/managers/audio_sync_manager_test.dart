import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/help_center/data/repositories/audio_sync_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAudioSyncRepository extends Mock implements IAudioSyncRepository {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

class AudioEntityFake extends Fake implements AudioEntity {}

class FileFake extends Fake implements File {}

/// path_provider stub pointing every directory at a real, disposable temp dir
/// so the manager's file operations work without a device.
class MockPathProviderPlatform extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  MockPathProviderPlatform(this.root);

  final String root;

  @override
  Future<String?> getApplicationDocumentsPath() async => root;

  @override
  Future<String?> getTemporaryPath() async => root;

  @override
  Future<String?> getApplicationSupportPath() async => root;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late MockAudioSyncRepository repository;
  late MockApiServerConfigure serverConfiguration;
  late AudioSyncManager sut;

  // The SUT is built ONCE: its constructor subscribes to the
  // FileDownloader() singleton's (single-subscription) updates stream, so a
  // second instance would throw "Stream has already been listened to".
  setUpAll(() {
    registerFallbackValue(AudioEntityFake());
    registerFallbackValue(FileFake());

    // Silence the background_downloader platform channel so the singleton's
    // bootstrap inside the constructor never throws MissingPluginException.
    const channel = MethodChannel('com.bbflight.background_downloader');
    TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async => null);

    tempDir = Directory.systemTemp.createTempSync('audio_sync_manager_test');
    PathProviderPlatform.instance = MockPathProviderPlatform(tempDir.path);

    repository = MockAudioSyncRepository();
    serverConfiguration = MockApiServerConfigure();

    sut = AudioSyncManager(
      audioRepository: repository,
      serverConfiguration: serverConfiguration,
    );
  });

  // SUT (and therefore its repository) is shared, so wipe interactions/stubs
  // between tests to keep verify() counts meaningful.
  setUp(() => reset(repository));

  tearDownAll(() {
    sut.dispose();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('mapEpochToUTC', () {
    test('converts a millisecond epoch to an ISO-8601 UTC string', () {
      final epoch = DateTime.utc(2024, 1, 2, 3, 4, 5).millisecondsSinceEpoch;

      final result = sut.mapEpochToUTC(epoch.toString());

      expect(result, '2024-01-02T03:04:05.000Z');
    });

    test('falls back to a valid recent UTC instant for a bad epoch', () {
      final result = sut.mapEpochToUTC('not-a-number');

      // does not throw; yields a parseable UTC timestamp near "now"
      final parsed = DateTime.parse(result);
      expect(parsed.isUtc, isTrue);
      expect(
        DateTime.now().toUtc().difference(parsed).inMinutes.abs(),
        lessThanOrEqualTo(2),
      );
    });
  });

  group('audioFile', () {
    test('builds the {epoch}_{session}_{sequence}.aac filename', () async {
      final path = await sut.audioFile(session: 'event-1', sequence: '3');

      final name = p.basename(path);
      final parts = name.split('_');
      expect(parts, hasLength(3));
      expect(int.tryParse(parts[0]), isNotNull); // epoch prefix
      expect(parts[1], 'event-1');
      expect(parts[2], '3.aac');
      expect(Directory(p.dirname(path)).existsSync(), isTrue);
    });

    test('normalizes a suffix without a leading dot', () async {
      final path =
          await sut.audioFile(session: 's', sequence: '1', suffix: 'aac');

      expect(p.extension(path), '.aac');
    });
  });

  group('cache', () {
    AudioEntity audio(String id) => AudioEntity(
          id: id,
          audioDuration: '1s',
          createdAt: DateTime(2021, 1, 1),
          canPlay: true,
          isRequested: true,
          isRequestGranted: true,
        );

    test('returns the cached file without downloading when it is populated',
        () async {
      // arrange: pre-populate the cache file beyond the empty threshold
      final cached = File(p.join(tempDir.path, 'cached-big.cached'));
      cached.writeAsBytesSync(List<int>.filled(200, 0));

      // act
      final result = await sut.cache(audio('cached-big'));

      // assert
      expect(result.isRight(), isTrue);
      verifyNever(() => repository.download(any(), any()));
    });

    test('downloads when the cache file is empty', () async {
      // arrange
      when(() => repository.download(any(), any()))
          .thenAnswer((_) async => right(const ValidField()));

      // act
      final result = await sut.cache(audio('cached-empty'));

      // assert
      expect(result.isRight(), isTrue);
      verify(() => repository.download(any(), any())).called(1);
    });

    test('propagates a download failure as Left', () async {
      // arrange
      when(() => repository.download(any(), any()))
          .thenAnswer((_) async => left(ServerFailure()));

      // act
      final result = await sut.cache(audio('cached-fail'));

      // assert
      expect(result.isLeft(), isTrue);
    });
  });
}
