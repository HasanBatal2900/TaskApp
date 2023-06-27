import 'package:flutter/material.dart';

class LeadingImage extends StatefulWidget {
  const LeadingImage({super.key, required this.image, required this.text});

  final String text;
  final String image;

  @override
  State<LeadingImage> createState() => _LeadingImageState();
}

class _LeadingImageState extends State<LeadingImage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadingAimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    fadingAimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: fadingAimation,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.image,
                height: fadingAimation.value * 380,
              ),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ],
          );
        });
  }
}
