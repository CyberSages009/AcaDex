import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? child;
  final IconData? icon; // ✅ added

  const AnimatedTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.child,
    this.icon,
  });

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..forward();

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.child ??
        ListTile(
          leading: widget.icon != null
              ? Icon(widget.icon, color: Colors.deepPurple)
              : null,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(widget.subtitle),
          onTap: widget.onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: content,
        ),
      ),
    );
  }
}
