import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volv_testi/utils/utils.dart';
import 'package:volv_testi/widgets/carousel/c_options.dart';
import 'package:volv_testi/widgets/carousel/c_slider.dart';
import 'package:volv_testi/widgets/carousel/vc_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _current = 0;
  final VolvCarouselController _controller = VolvCarouselController();
  final List<String> imgList = [
    'assets/seagull.png',
    'assets/car.png',
    'assets/volkswagen.png'
  ];

  int _index = 0;

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
                            _current = index;
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
                  SigninProviderWidget(
                    icon: "assets/apple.png",
                    label: "Apple",
                    onTap: () {
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SigninProviderWidget(
                    icon: "assets/google.png",
                    label: "Google",
                    onTap: () {
                      setState(() {
                        _index = 2;
                      });
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

class SigninProviderWidget extends StatelessWidget {
  final String icon;
  final String label;
  final Function()? onTap;

  const SigninProviderWidget(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              height: size.width * 0.075,
            ),
            SizedBox(
              width: size.width * 0.12,
            ),
            Text(
              'Sign in with $label',
              style: GoogleFonts.poppins(
                  fontSize: size.width * 0.045, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
