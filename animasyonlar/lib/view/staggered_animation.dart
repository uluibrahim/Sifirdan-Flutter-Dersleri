import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class StaggeredAnimation extends StatefulWidget {
  const StaggeredAnimation({Key? key}) : super(key: key);

  @override
  _StaggeredAnimationState createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  SequenceAnimation? sequenceAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: Duration.zero,
            to: Duration(seconds: 3),
            tag: "opacity")
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 200),
            from: Duration(seconds: 2),
            to: Duration(seconds: 3),
            tag: "width")
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 200),
            from: Duration(seconds: 2),
            to: Duration(seconds: 3),
            tag: "heigth")
        .addAnimatable(
            animatable: EdgeInsetsTween(
                begin: EdgeInsets.only(bottom: 200),
                end: EdgeInsets.only(bottom: 75)),
            from: Duration(seconds: 2),
            to: Duration(seconds: 3),
            curve: Curves.bounceOut,
            tag: "edge")
        .addAnimatable(
            animatable: BorderRadiusTween(
              begin: BorderRadius.circular(10),
              end: BorderRadius.circular(100),
            ),
            from: Duration(seconds: 2),
            to: Duration(seconds: 3),
            curve: Curves.bounceOut,
            tag: "borderRadius")
        .addAnimatable(
            animatable: ColorTween(
              begin: Colors.cyan,
              end: Colors.orange,
            ),
            from: Duration(seconds: 2),
            to: Duration(seconds: 3),
            curve: Curves.bounceOut,
            tag: "color")
        .animate(controller!);

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              child: AnimatedBuilder(
                animation: controller!,
                builder: (context, child) {
                  return Container(
                    padding: sequenceAnimation!["edge"].value,
                    child: Opacity(
                      opacity: sequenceAnimation!["opacity"].value,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              sequenceAnimation!["borderRadius"].value,
                          color: sequenceAnimation!["color"].value,
                        ),
                        height: sequenceAnimation!["heigth"].value,
                        width: sequenceAnimation!["width"].value,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
