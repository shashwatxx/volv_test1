import 'package:flutter/material.dart';

enum DataType { video, image }

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({Key? key, required this.imageUrl})
      : super(key: key);
  final String imageUrl;

  String getFileType() {
    final String fileType = imageUrl.substring(imageUrl.lastIndexOf('.') + 1);
    return fileType;
  }

  @override
  Widget build(BuildContext context) {
    print(getFileType());
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
      child:
          // FadeInImage.assetNetwork(
          //   placeholder: 'assets/1.png',
          //   image: imageUrl,
          // )

          Image.asset(
        imageUrl,
        width: size.width,
        height: size.height * 0.7,
        fit: BoxFit.cover,
      ),
    );
  }
}
