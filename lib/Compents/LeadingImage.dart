import 'package:flutter/material.dart';

class LeadingImage extends StatelessWidget {
  const LeadingImage({super.key,required this.image,required this.text});

  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 380,
        ),
         Text(
        text,
          style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
