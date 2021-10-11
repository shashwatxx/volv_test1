import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:volv_testi/services/firebase_service.dart';
import 'package:volv_testi/utils/utils.dart';
import 'package:volv_testi/widgets/carousel/vc_controller.dart';
import 'package:volv_testi/widgets/carousel/vc_options.dart';
import 'package:volv_testi/widgets/carousel/vc_slider.dart';
import 'package:volv_testi/widgets/sigin_provider_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final VolvCarouselController _controller = VolvCarouselController();
  final List<String> imgList = [
    'assets/seagull.png',
    'assets/car.png',
    'assets/volkswagen.png'
  ];

  int _index = 0;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment
                .bottomCenter, // 10% of the width, so there are ten blinds.
            colors: Utils.getColorPair(_index),
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Builder(builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider(
                    items: imgList
                        .map((e) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  e,
                                  height: 180,
                                  width: 180,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Lorem ipsum",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.width * 0.05),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Lorem ipsum dolor sit\namet,consectetur\nadipiscing elit',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ))
                        .toList(),
                    carouselController: _controller,
                    options: VolvCarouselOptions(
                        aspectRatio: 1.0,
                        onPageChanged: (index) {
                          setState(() {
                            _index = index;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 15,
                          height: 5.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _index == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 80),
                  SigninProviderButton(
                    icon: "assets/apple.png",
                    label: "Apple",
                    onTap: () {
                      Navigator.of(context).pushNamed('/home');
                      Fluttertoast.showToast(msg: "Login succesfull!");
                      //TODO: implement apple sign in
                      // _firebaseService.signInwithApple();
                    },
                  ),
                  const SizedBox(height: 20),
                  SigninProviderButton(
                    icon: "assets/google.png",
                    label: "Google",
                    onTap: () {
                      Navigator.of(context).pushNamed('/home');
                      Fluttertoast.showToast(msg: "Login succesfull!");
                      //TODO: implement google sign in
                      // _firebaseService.signInwithGoogle().then(
                      //     (value) => Navigator.of(context).pushNamed('/home'));
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?  ",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
