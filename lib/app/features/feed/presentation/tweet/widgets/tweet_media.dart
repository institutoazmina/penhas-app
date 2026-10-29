import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/managers/app_configuration.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../../../domain/entities/tweet_media_entity.dart';

@visibleForTesting
Uri? resolveTrustedMediaUri(String rawUrl, Uri trustedServer) {
  final trimmedUrl = rawUrl.trim();
  if (trimmedUrl.isEmpty) {
    return null;
  }

  final parsed = Uri.tryParse(trimmedUrl);
  if (parsed == null) {
    return null;
  }

  final resolved = parsed.hasScheme ? parsed : trustedServer.resolveUri(parsed);
  if (resolved.scheme != 'https' || trustedServer.scheme != 'https') {
    return null;
  }
  if (resolved.host.toLowerCase() != trustedServer.host.toLowerCase()) {
    return null;
  }
  if (resolved.port != trustedServer.port) {
    return null;
  }

  return resolved;
}

@immutable
class TrustedNetworkImage extends ImageProvider<TrustedNetworkImage> {
  const TrustedNetworkImage(
    this.url, {
    this.scale = 1.0,
    this.headers,
  });

  final String url;
  final double scale;
  final Map<String, String>? headers;

  @override
  Future<TrustedNetworkImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<TrustedNetworkImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    TrustedNetworkImage key,
    ImageDecoderCallback decode,
  ) {
    final chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode: decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: key.url,
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<TrustedNetworkImage>('Image key', key),
      ],
    );
  }

  Future<ui.Codec> _loadAsync(
    TrustedNetworkImage key,
    StreamController<ImageChunkEvent> chunkEvents, {
    required ImageDecoderCallback decode,
  }) async {
    final client = HttpClient();

    try {
      final resolved = Uri.parse(key.url);
      final request = await client.getUrl(resolved);
      request.followRedirects = false;
      key.headers?.forEach(request.headers.add);
      final response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        await response.drain<List<int>>(<int>[]);
        throw NetworkImageLoadException(
          statusCode: response.statusCode,
          uri: resolved,
        );
      }

      final bytes = await consolidateHttpClientResponseBytes(
        response,
        onBytesReceived: (cumulative, total) {
          chunkEvents.add(
            ImageChunkEvent(
              cumulativeBytesLoaded: cumulative,
              expectedTotalBytes: total,
            ),
          );
        },
      );
      if (bytes.isEmpty) {
        throw Exception('TrustedNetworkImage is an empty file: $resolved');
      }

      return decode(await ui.ImmutableBuffer.fromUint8List(bytes));
    } catch (_) {
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      chunkEvents.close();
      client.close();
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is TrustedNetworkImage &&
        other.url == url &&
        other.scale == scale &&
        mapEquals(other.headers, headers);
  }

  @override
  int get hashCode => Object.hash(
        url,
        scale,
        headers == null
            ? null
            : Object.hashAllUnordered(
                headers!.entries
                    .map((entry) => Object.hash(entry.key, entry.value)),
              ),
      );
}

class TweetMedia extends StatefulWidget {
  const TweetMedia({
    super.key,
    required this.media,
    this.highQuality = false,
    this.apiToken,
    this.trustedServer,
  });

  final List<TweetMediaEntity> media;
  final bool highQuality;
  final Future<String>? apiToken;
  final Uri? trustedServer;

  @override
  State<TweetMedia> createState() => _TweetMediaState();
}

class _TweetMediaState extends State<TweetMedia> {
  late Future<String> _apiToken;

  @override
  void initState() {
    super.initState();
    _apiToken = _resolveApiToken();
  }

  @override
  void didUpdateWidget(covariant TweetMedia oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.apiToken != oldWidget.apiToken) {
      _apiToken = _resolveApiToken();
    }
  }

  Future<String> _resolveApiToken() {
    return widget.apiToken ?? Modular.get<IAppConfiguration>().apiToken;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.media.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.media.map(_buildMedia).toList(),
      ),
    );
  }

  Widget _buildMedia(TweetMediaEntity media) {
    final uri = _mediaUri(media);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: uri == null
              ? const _MediaPlaceholder(isLoading: false)
              : FutureBuilder<String>(
                  future: _apiToken,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const _MediaPlaceholder(isLoading: true);
                    }

                    final token = snapshot.data ?? '';
                    if (snapshot.hasError || token.isEmpty) {
                      return const _MediaPlaceholder(isLoading: false);
                    }

                    return Image(
                      image: TrustedNetworkImage(
                        uri.toString(),
                        headers: {'X-Api-Key': token},
                      ),
                      fit: widget.highQuality ? BoxFit.contain : BoxFit.cover,
                      semanticLabel: 'Imagem da publicação',
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) {
                          return child;
                        }
                        return const _MediaPlaceholder(isLoading: true);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const _MediaPlaceholder(isLoading: false);
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }

  Uri? _mediaUri(TweetMediaEntity media) {
    final rawUrl = widget.highQuality
        ? (media.hd.isNotEmpty ? media.hd : media.sd)
        : (media.sd.isNotEmpty ? media.sd : media.hd);
    final trustedServer =
        widget.trustedServer ?? Modular.get<IAppConfiguration>().penhasServer;

    return resolveTrustedMediaUri(rawUrl, trustedServer);
  }
}

class _MediaPlaceholder extends StatelessWidget {
  const _MediaPlaceholder({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: DesignSystemColors.systemBackgroundColor,
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.broken_image_outlined,
                    color: DesignSystemColors.warnGrey,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Imagem indisponível',
                    style: kTextStyleFeedTweetShowReply.copyWith(
                      color: DesignSystemColors.warnGrey,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
