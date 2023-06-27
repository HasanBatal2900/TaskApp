import 'package:flutter/material.dart';
import 'package:task_app/Compents/LeadingImage.dart';
import 'package:task_app/Screens/TaskScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LeadingScreen extends StatefulWidget {
  const LeadingScreen({super.key});

  @override
  State<LeadingScreen> createState() => _LeadingScreenState();
}

class _LeadingScreenState extends State<LeadingScreen>
    with TickerProviderStateMixin {
  late AnimationController coloringController;
  late Animation coloringAnimation;
  late Animation secondColorAnimation;
  late AnimationController btnController;
  late Animation<double> btnAnimation;

  List<LeadingImage> leadings = [
    const LeadingImage(
        image: "images/1.png", text: "Adding tasks with soomth date"),
    const LeadingImage(
        image: "images/2.png", text: "Update your tasks as you want"),
    const LeadingImage(
        image: "images/3.png", text: "Have full control to all your tasks"),
  ];

  int activeIndex = 0;

  Widget btnChild = const Text(
    "Start Work",
    style: TextStyle(color: Colors.white),
  );
  Color btnColor = Colors.deepPurpleAccent;
  @override
  void initState() {
    super.initState();
    coloringController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
      ..repeat(reverse: true);
    coloringAnimation = ColorTween(
            begin: const Color.fromARGB(255, 156, 167, 241),
            end: const Color.fromARGB(255, 186, 153, 242))
        .animate(coloringController);
    secondColorAnimation = ColorTween(
            begin: const Color.fromARGB(255, 118, 108, 159),
            end: const Color.fromARGB(255, 145, 95, 232))
        .animate(coloringController);

    btnController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    btnAnimation =
        CurvedAnimation(parent: btnController, curve: Curves.bounceIn);
  }

  @override
  void dispose() {
    super.dispose();
    coloringController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: coloringController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    coloringAnimation.value,
                    secondColorAnimation.value
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
              );
            },
          ),
          Positioned(
            bottom: 245,
            left: 160,
            child: AnimatedSmoothIndicator(
              duration: const Duration(milliseconds: 500),
              activeIndex: activeIndex,
              count: leadings.length,
              axisDirection: Axis.horizontal,
              curve: Curves.bounceIn,
              effect: SwapEffect(
                  strokeWidth: 1.3,
                  dotWidth: 10,
                  dotHeight: 10,
                  paintStyle: PaintingStyle.stroke,
                  activeDotColor: const Color.fromARGB(255, 175, 137, 242),
                  radius: 20,
                  dotColor: Colors.white.withOpacity(0.7),
                  type: SwapType.yRotation),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 120,
            child: AnimatedBuilder(
              animation: btnAnimation,
              builder: (context, child) {
                return MaterialButton(
                    minWidth: 150,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: btnColor,
                    onPressed: () async {
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        setState(
                          () {
                            btnController.forward();
                            btnColor = const Color.fromARGB(255, 98, 81, 197);
                            btnChild = RotationTransition(
                              turns: btnAnimation,
                              alignment: Alignment.center,
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.done,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            );

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      animation = CurvedAnimation(
                                        curve: Curves.fastOutSlowIn,
                                        parent: animation,
                                      );

                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const TaskScreen();
                                    },
                                  ));
                              setState(() {
                                btnChild = const Text(
                                  "Start Work",
                                  style: TextStyle(color: Colors.white),
                                );
                              });
                            });
                          },
                        );
                      });

                      setState(() {
                        btnChild = const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      });
                    },
                    child: btnChild);
              },
            ),
          )
        ],
      ),
    );
  }
}
