import 'package:flutter/material.dart';

class ImageWithPlaceholder extends StatefulWidget {
  final String imageUrl;
  final Future<String> Function() fetchNewImageUrl;

  const ImageWithPlaceholder(
      {required this.imageUrl, required this.fetchNewImageUrl});

  @override
  _ImageWithPlaceholderState createState() => _ImageWithPlaceholderState();
}

class _ImageWithPlaceholderState extends State<ImageWithPlaceholder> {
  late String currentImageUrl;

  @override
  void initState() {
    super.initState();
    currentImageUrl = widget.imageUrl;
  }

  Future<void> _refreshImageUrl() async {
    final newUrl = await widget.fetchNewImageUrl();
    setState(() {
      currentImageUrl = newUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      currentImageUrl,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        // Optionally, you can refresh the URL here and retry loading
        _refreshImageUrl();
        return Icon(
          Icons.error,
          color: Colors.red,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
    );
  }
}
