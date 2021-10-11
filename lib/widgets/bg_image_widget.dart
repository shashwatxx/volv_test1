import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({Key? key, required this.imageUrl})
      : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.transparent,
              Colors.transparent,
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstIn,
      child: Image.network(
        imageUrl,
        width: size.width,
        height: size.height * 0.7,
        fit: BoxFit.cover,
      ),
    );
  }
}
