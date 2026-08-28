import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart' hide Task;
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

class MockFileDownloader extends Mock implements FileDownloader {}

class MockDatabase extends Mock implements Database {}

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
  Future<String?> getTemporaryPath() async => p.join(root, 'temporary');

  @override
  Future<String?> getApplicationSupportPath() async => p.join(root, 'support');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late MockAudioSyncRepository repository;
  late MockApiServerConfigure serverConfiguration;
  late MockFileDownloader downloader;
  late MockDatabase database;
  late AudioSyncManager sut;

  // The SUT is built ONCE: its constructor subscribes to the
  // FileDownloader() singleton's (single-subscription) updates stream, so a
  // second instance would throw "Stream has already been listened to".
  setUpAll(() {
    registerFallbackValue(AudioEntityFake());
    registerFallbackValue(FileFake());
    registerFallbackValue(
      UploadTask(filename: 'fallback.aac', url: 'https://example.test'),
    );

    // Silence the background_downloader platform channel so the singleton's
    // bootstrap inside the constructor never throws MissingPluginException.
    const channel = MethodChannel('com.bbflight.background_downloader');
    TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async => null);

    tempDir = Directory.systemTemp.createTempSync('audio_sync_manager_test');
    PathProviderPlatform.instance = MockPathProviderPlatform(tempDir.path);

    repository = MockAudioSyncRepository();
    serverConfiguration = MockApiServerConfigure();
    downloader = MockFileDownloader();
    database = MockDatabase();

    when(() => downloader.database).thenReturn(database);
    when(() => database.recordForId(any())).thenAnswer((_) async => null);
    when(() => database.deleteRecordWithId(any())).thenAnswer((_) async {});
    when(() => downloader.allTasks(
          allGroups: true,
          includeTasksWaitingToRetry: true,
        )).thenAnswer((_) async => []);
    when(() => downloader.enqueue(any())).thenAnswer((_) async => true);

    sut = AudioSyncManager(
      audioRepository: repository,
      serverConfiguration: serverConfiguration,
      downloader: downloader,
    );
  });

  // SUT (and therefore its repository) is shared, so wipe interactions/stubs
  // between tests to keep verify() counts meaningful.
  setUp(() {
    reset(repository);
    reset(serverConfiguration);
    reset(downloader);
    reset(database);

    when(() => downloader.database).thenReturn(database);
    when(() => database.recordForId(any())).thenAnswer((_) async => null);
    when(() => database.deleteRecordWithId(any())).thenAnswer((_) async {});
    when(() => downloader.allTasks(
          allGroups: true,
          includeTasksWaitingToRetry: true,
        )).thenAnswer((_) async => []);
    when(() => downloader.enqueue(any())).thenAnswer((_) async => true);
  });

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
    const session = '550e8400-e29b-41d4-a716-446655440000';

    test('builds a recovery-compatible filename', () async {
      final path = await sut.audioFile(session: session, sequence: '3');

      final name = p.basename(path);
      final parts = name.split('_');
      expect(parts, hasLength(3));
      expect(int.tryParse(parts[0]), isNotNull); // epoch prefix
      expect(parts[1], session);
      expect(parts[2], '3.aac');
      expect(Directory(p.dirname(path)).existsSync(), isTrue);
    });

    test('normalizes a suffix without a leading dot', () async {
      final path = await sut.audioFile(
        session: session.toUpperCase(),
        sequence: '001',
        suffix: 'AAC',
      );

      expect(p.extension(path), '.aac');
      expect(p.basename(path).contains('_${session}_1.aac'), isTrue);
    });

    test('rejects sessions and sequences outside the recovery contract',
        () async {
      expect(
        sut.audioFile(session: 'not-a-uuid', sequence: '1'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        sut.audioFile(session: session, sequence: '1001'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        sut.audioFile(session: session, sequence: '1', suffix: '.mp4'),
        throwsA(isA<ArgumentError>()),
      );
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
      final cached =
          File(p.join(tempDir.path, 'temporary', 'cached-big.cached'));
      cached.parent.createSync(recursive: true);
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

  group('upload recovery', () {
    const orphanFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440000_1.aac';
    const activeFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440001_1.aac';
    const failedFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440002_1.aac';
    const serializedFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440003_1.aac';
    const completeFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440004_1.aac';
    const persistedCompleteFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440011_1.aac';
    const nativePendingFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440007_1.aac';
    const legacyCanceledFileName =
        '1700000000000_550e8400-e29b-41d4-a716-446655440009_1.aac';

    void stubServerConfiguration() {
      when(() => serverConfiguration.baseUri)
          .thenReturn(Uri.parse('https://example.test/api'));
      when(() => serverConfiguration.apiToken).thenAnswer((_) async => 'token');
      when(() => serverConfiguration.userAgent)
          .thenAnswer((_) async => 'agent');
    }

    File createAudioFile(String fileName, {int size = 32}) {
      final file = File(p.join(tempDir.path, fileName));
      file.parent.createSync(recursive: true);
      file.writeAsBytesSync(List<int>.filled(size, 1));
      addTearDown(() async {
        if (await file.exists()) await file.delete();
      });
      return file;
    }

    TaskRecord recordFor(
      String fileName,
      TaskStatus status, {
      bool legacy = false,
    }) {
      final parts = p.basenameWithoutExtension(fileName).split('_');
      final task = UploadTask(
        taskId: fileName,
        filename: fileName,
        url: 'https://example.test/me/audios',
        group: legacy
            ? FileDownloader.defaultGroup
            : AudioSyncManager.audioUploadGroup,
        fileField: 'media',
        fields: {
          'sha1': '0' * 40,
          'event_id': parts[1],
          'event_sequence': parts[2],
          'cliente_created_at': '2024-01-01T00:00:00.000Z',
          'current_time': '2024-01-01T00:00:00.000Z',
        },
      );
      return TaskRecord(task, status, 0, -1);
    }

    test('does not scan or enqueue before authentication', () async {
      const fileName =
          '1700000000000_550e8400-e29b-41d4-a716-446655440005_1.aac';
      final file = createAudioFile(fileName);
      when(() => serverConfiguration.apiToken).thenAnswer((_) async => '');

      await sut.syncAudio();

      verifyNever(() => database.recordForId(any()));
      verifyNever(() => downloader.enqueue(any()));
      expect(file.existsSync(), isTrue);
    });

    test('aborts recovery when downloader startup failed', () async {
      AudioSyncManager.prepareForDownloaderStart();
      AudioSyncManager.markDownloaderStartupFailed();
      stubServerConfiguration();
      final file = createAudioFile(
        '1700000000000_550e8400-e29b-41d4-a716-446655440008_1.aac',
      );
      final failedStartupManager = AudioSyncManager(
        audioRepository: repository,
        serverConfiguration: serverConfiguration,
        downloader: downloader,
        waitForDownloaderStartup: true,
      );

      await failedStartupManager.syncAudio();
      failedStartupManager.dispose();

      verifyNever(() => database.recordForId(any()));
      verifyNever(() => downloader.allTasks(
            allGroups: true,
            includeTasksWaitingToRetry: true,
          ));
      verifyNever(() => downloader.enqueue(any()));
      expect(file.existsSync(), isTrue);
    });

    test('discovers an orphan and uses a relative application path', () async {
      stubServerConfiguration();
      final file = createAudioFile(orphanFileName);
      expect(
        (await sut.dirAudioUploadContent()).single.path,
        file.path,
      );

      await sut.syncAudio();

      final captured = verify(() => downloader.enqueue(captureAny()))
          .captured
          .single as UploadTask;
      expect(captured.taskId, orphanFileName);
      expect(captured.filename, orphanFileName);
      expect(captured.directory, '');
      expect(captured.baseDirectory, BaseDirectory.applicationDocuments);
      expect(captured.retries, 5);
      expect(captured.url, 'https://example.test/me/audios');
      expect(
          captured.fields['event_id'], '550e8400-e29b-41d4-a716-446655440000');
      expect(captured.fields['event_sequence'], '1');
      expect(captured.fields['sha1'],
          sha1.convert(file.readAsBytesSync()).toString());
      expect(file.existsSync(), isTrue);
    });

    test('does not enqueue active records or invalid files', () async {
      final activeFile = createAudioFile(activeFileName);
      final invalidFile = createAudioFile('not-an-audio.aac', size: 2);
      when(() => database.recordForId(activeFileName)).thenAnswer(
          (_) async => recordFor(activeFileName, TaskStatus.running));

      await sut.syncAudio();

      verifyNever(() => downloader.enqueue(any()));
      expect(activeFile.existsSync(), isTrue);
      expect(invalidFile.existsSync(), isTrue);
    });

    test('removes a failed record and re-enqueues with the same task id',
        () async {
      stubServerConfiguration();
      createAudioFile(failedFileName);
      when(() => database.recordForId(failedFileName)).thenAnswer(
        (_) async => recordFor(
          failedFileName,
          TaskStatus.failed,
          legacy: true,
        ),
      );

      await sut.syncAudio();

      verify(() => database.deleteRecordWithId(failedFileName)).called(1);
      final captured = verify(() => downloader.enqueue(captureAny()))
          .captured
          .last as UploadTask;
      expect(captured.taskId, failedFileName);
    });

    test('recognizes a legacy canceled audio record for retry', () async {
      stubServerConfiguration();
      createAudioFile(legacyCanceledFileName);
      when(() => database.recordForId(legacyCanceledFileName)).thenAnswer(
        (_) async => recordFor(
          legacyCanceledFileName,
          TaskStatus.canceled,
          legacy: true,
        ),
      );

      await sut.syncAudio();

      verify(() => database.deleteRecordWithId(legacyCanceledFileName))
          .called(1);
      final captured = verify(() => downloader.enqueue(captureAny()))
          .captured
          .last as UploadTask;
      expect(captured.taskId, legacyCanceledFileName);
    });

    test('serializes concurrent scans and does not duplicate an upload',
        () async {
      stubServerConfiguration();
      createAudioFile(serializedFileName);
      var activeLookups = 0;
      var maxActiveLookups = 0;
      when(() => database.recordForId(serializedFileName))
          .thenAnswer((_) async {
        activeLookups++;
        maxActiveLookups =
            activeLookups > maxActiveLookups ? activeLookups : maxActiveLookups;
        await Future<void>.delayed(const Duration(milliseconds: 10));
        activeLookups--;
        return null;
      });

      await Future.wait([sut.syncAudio(), sut.syncAudio()]);

      expect(maxActiveLookups, 1);
      verify(() => downloader.enqueue(any())).called(1);
    });

    test('does not enqueue when a native pending task lacks a database record',
        () async {
      stubServerConfiguration();
      final file = createAudioFile(nativePendingFileName);
      final nativeTask = recordFor(
        nativePendingFileName,
        TaskStatus.enqueued,
      ).task;
      when(() => downloader.allTasks(
            allGroups: true,
            includeTasksWaitingToRetry: true,
          )).thenAnswer((_) async => [nativeTask]);

      await sut.syncAudio();

      verifyNever(() => downloader.enqueue(any()));
      expect(file.existsSync(), isTrue);
    });

    test('deletes only after complete and preserves the file on failure',
        () async {
      stubServerConfiguration();
      final file = createAudioFile(completeFileName);
      final unrelatedFile = createAudioFile('other-task.aac');
      final unrelatedTask = UploadTask(
        taskId: 'other-task.aac',
        filename: 'other-task.aac',
        url: 'https://example.test/me/other',
        group: AudioSyncManager.audioUploadGroup,
        baseDirectory: BaseDirectory.applicationDocuments,
      );

      sut.handleUpdateForTesting(
        TaskStatusUpdate(unrelatedTask, TaskStatus.complete),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(unrelatedFile.existsSync(), isTrue);

      await sut.syncAudio();
      final task = verify(() => downloader.enqueue(captureAny())).captured.last
          as UploadTask;

      sut.handleUpdateForTesting(
        TaskStatusUpdate(task, TaskStatus.failed),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(file.existsSync(), isTrue);

      sut.handleUpdateForTesting(
        TaskStatusUpdate(task, TaskStatus.complete),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(file.existsSync(), isFalse);
    });

    test('does not enqueue files that fail the strict filename gate', () async {
      stubServerConfiguration();
      final invalidFiles = <File>[
        createAudioFile('not-an-audio.aac'),
        createAudioFile(
          '946684799999_550e8400-e29b-41d4-a716-446655440006_1.aac',
        ),
        createAudioFile(
          '1700000000000_550e8400-e29b-41d4-a716-446655440006_1001.aac',
        ),
        createAudioFile(
          '1700000000000_550e8400-e29b-11d4-a716-446655440006_1.aac',
        ),
      ];

      await sut.syncAudio();

      verifyNever(() => downloader.enqueue(any()));
      for (final file in invalidFiles) {
        expect(file.existsSync(), isTrue);
      }
    });

    test('cleans a file left by a recognized complete record', () async {
      stubServerConfiguration();
      final file = createAudioFile(persistedCompleteFileName);
      when(() => database.recordForId(persistedCompleteFileName)).thenAnswer(
        (_) async => recordFor(
          persistedCompleteFileName,
          TaskStatus.complete,
        ),
      );

      await sut.syncAudio();

      expect(file.existsSync(), isFalse);
      verifyNever(() => database.deleteRecordWithId(any()));
      verifyNever(() => downloader.enqueue(any()));
    });

    test('leaves an unrelated failed record untouched', () async {
      stubServerConfiguration();
      const fileName =
          '1700000000000_550e8400-e29b-41d4-a716-446655440010_1.aac';
      createAudioFile(fileName);
      final unrelatedTask = UploadTask(
        taskId: fileName,
        filename: fileName,
        url: 'https://example.test/me/audios',
      );
      when(() => database.recordForId(fileName)).thenAnswer(
        (_) async => TaskRecord(unrelatedTask, TaskStatus.failed, 0, -1),
      );

      await sut.syncAudio();

      verifyNever(() => database.deleteRecordWithId(fileName));
      verifyNever(() => downloader.enqueue(any()));
    });
  });
}
