import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoImage extends StatelessWidget {
 final String? url;

  const FullPhotoImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: PhotoView(imageProvider: NetworkImage(url!),),),
    );
  }
}