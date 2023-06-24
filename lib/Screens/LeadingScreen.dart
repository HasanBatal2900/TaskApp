import 'package:flutter/material.dart';
import 'package:task_app/Compents/LeadingImage.dart';
import 'package:task_app/Screens/TaskScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LeadingScreen extends StatefulWidget {
  const LeadingScreen({super.key});

  @override
  State<LeadingScreen> createState() => _LeadingScreenState();
}

class _LeadingScreenState extends State<LeadingScreen> {
  List<LeadingImage> leadings = [
    const LeadingImage(
        image: "images/1.png", text: "Adding tasks with soomth date"),
    const LeadingImage(
        image: "images/2.png", text: "Update your tasks as you want"),
    const LeadingImage(
        image: "images/3.png", text: "Have full control to all your tasks"),
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 156, 167, 241),
                Colors.deepPurple,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 600,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        activeIndex = value;
                      });
                    },
                    itemCount: leadings.length,
                    itemBuilder: (context, index) {
                      return leadings[index];
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 245,
            left: 130,
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: leadings.length,
              axisDirection: Axis.horizontal,
              curve: Curves.bounceIn,
              effect: SwapEffect(
                  strokeWidth: 1.3,
                  dotWidth: 35,
                  dotHeight: 10,
                  paintStyle: PaintingStyle.stroke,
                  activeDotColor: const Color.fromARGB(255, 175, 137, 242),
                  radius: 20,
                  dotColor: Colors.white.withOpacity(0.7),
                  type: SwapType.yRotation),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 120,
            child: MaterialButton(
              minWidth: 150,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.deepPurpleAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        animation = CurvedAnimation(
                          curve: Curves.fastOutSlowIn,
                          parent: animation,
                        );

                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const TaskScreen();
                      },
                    ));
              },
              child: const Text(
                "Start Work",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
