import 'package:flutter/cupertino.dart';

class HoverBuilder extends StatefulWidget {
  final Widget Function(bool hovered) onHover;

  const HoverBuilder({super.key, required this.onHover});

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.onHover(_isHovered),
    );
  }
}