import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final IconData? icon;

  const AnimatedTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.icon,
  });

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  bool _hover = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: widget.icon != null ? Icon(widget.icon) : null,
            title: Text(widget.title),
            subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
