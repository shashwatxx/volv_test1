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
            TextButton.icon(
              onPressed: null,
              icon: Icon(
                FontAwesomeIcons.clock,
                size: size.height * 0.025,
                color: Colors.grey.shade300,
              ),
              label: Text(
                data.postedTime,
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            Text(
              "CHECK IT OUT",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, color: Colors.orange),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            Row(
              children: [
                Text(
                  "Share",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.file_upload_outlined, color: Colors.grey)
              ],
            )
          ],
        )
      ],
    );
  }
}
