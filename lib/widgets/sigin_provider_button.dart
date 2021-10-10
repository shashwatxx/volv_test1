import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninProviderButton extends StatelessWidget {
  final String icon;
  final String label;
  final Function()? onTap;

  const SigninProviderButton(
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
