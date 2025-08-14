import 'package:flutter/material.dart';

class AnimatedTile extends StatelessWidget {
  final Widget child;
  final int index;

  const AnimatedTile({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
        begin: const Offset(0.3, 0),
        end: Offset.zero,
      ),
      duration: Duration(milliseconds: 400 + (index * 80)),
      curve: Curves.easeOutCubic,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset * MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: 1 - (offset.dx.abs() * 3),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
