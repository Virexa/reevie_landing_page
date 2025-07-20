import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class StatisticView extends StatefulWidget {
  final String description;
  final String count;
  final Widget icon;

  const StatisticView({
    super.key,
    required this.description,
    required this.count,
    required this.icon,
  });

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  bool _showIcon = true;
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();
    _startLoopingAnimation();
  }

  void _startLoopingAnimation() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 1600), (
      timer,
    ) {
      setState(() {
        _showIcon = !_showIcon;
      });
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: _showIcon ? 0 : 5,
              end: _showIcon ? 0 : 5,
            ),
            duration: const Duration(milliseconds: 300),
            builder: (context, blurValue, child) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: _showIcon
                    ? _buildBlurred(
                        widget.icon,
                        blurValue,
                        key: const ValueKey('icon'),
                      )
                    : _buildBlurred(
                        Text(
                          widget.count,
                          key: const ValueKey('count'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        blurValue,
                      ),
              );
            },
          ),
        ),
        Text(
          widget.description,
          style: const TextStyle(fontSize: 12, color: Colors.white54),
          overflow: TextOverflow.visible,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBlurred(Widget child, double blur, {Key? key}) {
    return ClipRect(
      key: key,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _showIcon ? 1 : 1,
          child: child,
        ),
      ),
    );
  }
}
