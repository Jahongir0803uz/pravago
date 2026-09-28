import 'package:flutter/material.dart';

Animation<double> fade(
  double begin,
  double end,
  AnimationController controller,
) {
  return CurvedAnimation(
    parent: controller,
    curve: Interval(begin, end, curve: Curves.easeOut),
  );
}

Animation<Offset> _slide(
  double begin,
  double end,
  AnimationController controller,
) {
  return Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: Curves.easeOut),
    ),
  );
}

Widget fadeSlideItem(
  Widget child,
  double begin,
  double end,
  AnimationController controller,
) {
  return FadeTransition(
    opacity: fade(begin, end, controller),
    child: SlideTransition(
      position: _slide(begin, end, controller),
      child: child,
    ),
  );
}
