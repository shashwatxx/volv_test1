import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volv_testi/data.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Article data;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          data.heading,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data.description,
          style: GoogleFonts.poppins(fontSize: size.width * 0.038),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(FontAwesomeIcons.angleDoubleUp),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: Text(
                  "CHECK IT OUT",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(247, 220, 202, 1),
                  Color.fromRGBO(214, 220, 235, 1),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/send.png',
                height: size.width * 0.07,
              ),
            )
          ],
        )
      ],
    );
  }
}