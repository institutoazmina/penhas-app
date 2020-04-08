import 'package:flutter/material.dart';
import 'package:mastodon_dart/mastodon_dart.dart';

import 'media_grid.dart';
import 'media_screen.dart';

/// This widget renders images found in a Status
/// todo: add support for other media
class Media extends StatelessWidget {
  final Status status;

  Media({@required this.status});

  List<Attachment> get images => status.mediaAttachments
      .where((a) => a.type == AttachmentType.image)
      .take(4)
      .toList();

  bool get hasImages => images.isNotEmpty;

  _handleNavigate(BuildContext context, Attachment attachment) {
    showMediaScreen(context, status, attachment);
  }

  @override
  Widget build(BuildContext context) {
    if (!hasImages) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: MediaGrid(
            children: images
                .map(
                  (i) => GestureDetector(
                    onTap: () => _handleNavigate(context, i),

                    /// The box fit has to match the sibling Hero
                    child: Hero(
                      tag: i.id,
                      child: Image.network(
                        i.previewUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }
  }
}
