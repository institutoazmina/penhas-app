import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_media_entity.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_body.dart';
import 'package:penhas/app/features/feed/presentation/tweet/widgets/tweet_media.dart';

import '../../../../../../utils/test_utils.dart';

void main() {
  const media = TweetMediaEntity(
    sd: 'https://api.test/media-download/?m=1&q=sd&h=sd',
    hd: 'https://api.test/media-download/?m=1&q=hd&h=hd',
  );
  final trustedServer = Uri.parse('https://api.test');

  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(<int>[]);
  });

  group(resolveTrustedMediaUri, () {
    test('resolves relative API URLs against the trusted server', () {
      final result = resolveTrustedMediaUri(
        'media-download/?m=1&q=sd&h=sd',
        trustedServer,
      );

      expect(
        result,
        Uri.parse('https://api.test/media-download/?m=1&q=sd&h=sd'),
      );
    });

    test('accepts same-origin HTTPS URLs with the default port', () {
      expect(
        resolveTrustedMediaUri(
          'https://api.test/media-download/?m=1',
          trustedServer,
        ),
        isNotNull,
      );
      expect(
        resolveTrustedMediaUri(
          'https://api.test:443/media-download/?m=1',
          trustedServer,
        ),
        isNotNull,
      );
    });

    test('rejects HTTP URLs', () {
      expect(
        resolveTrustedMediaUri(
          'http://api.test/media-download/?m=1',
          trustedServer,
        ),
        isNull,
      );
    });

    test('rejects external hosts', () {
      expect(
        resolveTrustedMediaUri(
          'https://evil.test/media-download/?m=1',
          trustedServer,
        ),
        isNull,
      );
      expect(
        resolveTrustedMediaUri(
          'https://api.test.evil.test/media-download/?m=1',
          trustedServer,
        ),
        isNull,
      );
    });

    test('rejects different ports', () {
      expect(
        resolveTrustedMediaUri(
          'https://api.test:8443/media-download/?m=1',
          trustedServer,
        ),
        isNull,
      );
    });

    test('rejects scheme-relative external hosts', () {
      expect(
        resolveTrustedMediaUri(
          '//evil.test/media-download/?m=1',
          trustedServer,
        ),
        isNull,
      );
    });
  });

  group(TweetBody, () {
    testWidgets('renders text and media with the api key header',
        (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          buildTestableWidget(
            TweetBody(
              content: 'Texto da publicação',
              badges: const [],
              media: const [media],
              apiToken: Future.value('token-123'),
              trustedServer: trustedServer,
            ),
          ),
        );
        await tester.pump();
        await tester.pump();

        expect(find.byType(Html), findsOneWidget);

        final image = tester.widget<Image>(find.byType(Image));
        final provider = image.image as TrustedNetworkImage;

        expect(provider.url, media.sd);
        expect(provider.headers, {'X-Api-Key': 'token-123'});
      });
    });

    testWidgets('renders relative API media with the api key header',
        (tester) async {
      const relativeMedia = TweetMediaEntity(
        sd: 'media-download/?m=1&q=sd&h=sd',
        hd: 'media-download/?m=1&q=hd&h=hd',
      );

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          buildTestableWidget(
            TweetBody(
              content: '',
              badges: const [],
              media: const [relativeMedia],
              apiToken: Future.value('token-123'),
              trustedServer: trustedServer,
            ),
          ),
        );
        await tester.pump();
        await tester.pump();

        final image = tester.widget<Image>(find.byType(Image));
        final provider = image.image as TrustedNetworkImage;

        expect(
          provider.url,
          'https://api.test/media-download/?m=1&q=sd&h=sd',
        );
        expect(provider.headers, {'X-Api-Key': 'token-123'});
      });
    });

    testWidgets('uses hd media in detail', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          buildTestableWidget(
            TweetBody(
              content: 'Texto da publicação',
              badges: const [],
              media: const [media],
              highQualityMedia: true,
              apiToken: Future.value('token-123'),
              trustedServer: trustedServer,
            ),
          ),
        );
        await tester.pump();
        await tester.pump();

        final image = tester.widget<Image>(find.byType(Image));
        final provider = image.image as TrustedNetworkImage;

        expect(provider.url, media.hd);
      });
    });

    testWidgets('shows loading while the api token is resolved',
        (tester) async {
      final token = Completer<String>();

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          buildTestableWidget(
            TweetBody(
              content: '',
              badges: const [],
              media: const [media],
              apiToken: token.future,
              trustedServer: trustedServer,
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(Image), findsNothing);

        token.complete('token-123');
        await tester.pump();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets('shows an error placeholder when the api token is empty',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          TweetBody(
            content: '',
            badges: const [],
            media: const [media],
            apiToken: Future.value(''),
            trustedServer: trustedServer,
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.text('Imagem indisponível'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('does not load external media with the api key header',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          TweetBody(
            content: '',
            badges: const [],
            media: const [
              TweetMediaEntity(
                sd: 'https://evil.test/media-download/?m=1&q=sd',
                hd: 'https://evil.test/media-download/?m=1&q=hd',
              ),
            ],
            apiToken: Future.value('token-123'),
            trustedServer: trustedServer,
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.byType(Image), findsNothing);
      expect(find.text('Imagem indisponível'), findsOneWidget);
    });

    testWidgets('does not load HTTP media with the api key header',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          TweetBody(
            content: '',
            badges: const [],
            media: const [
              TweetMediaEntity(
                sd: 'http://api.test/media-download/?m=1&q=sd',
                hd: 'http://api.test/media-download/?m=1&q=hd',
              ),
            ],
            apiToken: Future.value('token-123'),
            trustedServer: trustedServer,
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.byType(Image), findsNothing);
      expect(find.text('Imagem indisponível'), findsOneWidget);
    });

    testWidgets('does not load media from a different port with the api key',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          TweetBody(
            content: '',
            badges: const [],
            media: const [
              TweetMediaEntity(
                sd: 'https://api.test:8443/media-download/?m=1&q=sd',
                hd: 'https://api.test:8443/media-download/?m=1&q=hd',
              ),
            ],
            apiToken: Future.value('token-123'),
            trustedServer: trustedServer,
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.byType(Image), findsNothing);
      expect(find.text('Imagem indisponível'), findsOneWidget);
    });

    testWidgets('does not follow redirects with the api key header',
        (tester) async {
      const redirectMedia = TweetMediaEntity(
        sd: 'https://api.test/media-download/?m=redirect&q=sd&h=sd',
        hd: 'https://api.test/media-download/?m=redirect&q=hd&h=hd',
      );
      final client = _MockHttpClient();
      final request = _MockHttpClientRequest();
      final response = _MockHttpClientResponse();
      final headers = _MockHttpHeaders();

      when(() => client.getUrl(any())).thenAnswer((_) async => request);
      when(() => request.headers).thenReturn(headers);
      when(() => request.close()).thenAnswer((_) async => response);
      when(() => response.statusCode).thenReturn(HttpStatus.found);
      when(() => response.drain<List<int>>(any()))
          .thenAnswer((_) async => <int>[]);

      await HttpOverrides.runZoned(
        () async {
          await tester.pumpWidget(
            buildTestableWidget(
              TweetBody(
                content: '',
                badges: const [],
                media: const [redirectMedia],
                apiToken: Future.value('token-123'),
                trustedServer: trustedServer,
              ),
            ),
          );
          await tester.pumpAndSettle(
            const Duration(milliseconds: 100),
            EnginePhase.sendSemanticsUpdate,
            const Duration(seconds: 2),
          );

          expect(find.text('Imagem indisponível'), findsOneWidget);
          verify(() => request.followRedirects = false).called(1);
          verify(() => client.getUrl(any())).called(1);
        },
        createHttpClient: (_) => client,
      );
    });

    testWidgets('renders image-only posts without an empty html body',
        (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          buildTestableWidget(
            TweetBody(
              content: '',
              badges: const [],
              media: const [media],
              apiToken: Future.value('token-123'),
              trustedServer: trustedServer,
            ),
          ),
        );
        await tester.pump();
        await tester.pump();

        expect(find.byType(Html), findsNothing);
        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets('does not render media when the list is empty', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          TweetBody(
            content: 'Publicação somente com texto',
            badges: const [],
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Image), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Html), findsOneWidget);
    });
  });
}

class _MockHttpClient extends Mock implements HttpClient {}

class _MockHttpClientRequest extends Mock implements HttpClientRequest {}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {}

class _MockHttpHeaders extends Mock implements HttpHeaders {}
