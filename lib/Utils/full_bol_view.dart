import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullBolImage extends StatelessWidget {
  final String? url;

  const FullBolImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,),
      body: Container(
        child: PhotoView(imageProvider: NetworkImage(url!),),),
    );
  }
}