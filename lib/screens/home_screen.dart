import 'package:flutter/material.dart';
import 'package:volv_testi/data.dart';
import 'package:volv_testi/widgets/bg_image_widget.dart';
import 'package:volv_testi/widgets/data_card.dart';
import 'package:volv_testi/widgets/volv_custom_scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = data[0].imageUrl;

  void _onScroll(ScrollEventType type, {int? currentIndex}) {
    print(
        "Scroll callback received with data: {type: $type, and index: $currentIndex}");
    setState(() {
      imageUrl = currentIndex != null
          ? data[currentIndex].imageUrl
          : "https://wallup.net/wp-content/uploads/2018/03/19/580174-colorful-blurred-vertical-portrait_display-748x1330.jpg";
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          size: size.width * 0.09,
          color: Colors.white,
        ),
      ),
      body: Stack(
        // alignment: Alignment.center,
        children: [
          BackgroundImageWidget(imageUrl: data[0].imageUrl),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: size.width,
                height: size.height * 0.50,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: VolvCustomScroller(
                  contentSize: data.length,
                  onScrollEvent: _onScroll,
                  builder: (BuildContext context, int index) {
                    return DataCard(data: data[index]);
                  },
                ),
              ))
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
