import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const ZoomableCachedNetworkImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(),
              body: PhotoView(
                imageProvider: CachedNetworkImageProvider(imageUrl),
              ),
            ),
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}
