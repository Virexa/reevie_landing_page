import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

/// A horizontally scrolling, infinitely looping carousel with smooth scale animations.
///
/// Displays a configurable number of cards (default 5), scales up the center card,
/// auto-scrolls only (no user gestures), and allows optional spacing between cards.
class HorizontalMovieCarousel extends StatefulWidget {
  /// The list of card widgets to display.
  final List<Widget> cards;

  /// Scale factor applied to the center card.
  final double centerCardScale;

  /// Number of items visible in the viewport at once.
  final int visibleCount;

  /// Duration between automatic page changes.
  final Duration autoChangeDuration;

  /// Space between items (in logical pixels).
  final double spacing;

  const HorizontalMovieCarousel({
    super.key,
    required this.cards,
    this.centerCardScale = 1.2,
    this.visibleCount = 5,
    this.autoChangeDuration = const Duration(seconds: 3),
    this.spacing = 0,
  }) : assert(cards.length > 0, 'Cards list cannot be empty'),
       assert(visibleCount > 0, 'visibleCount must be at least 1');

  @override
  State<HorizontalMovieCarousel> createState() =>
      _HorizontalMovieCarouselState();
}

class _HorizontalMovieCarouselState extends State<HorizontalMovieCarousel> {
  late PageController _pageController;
  late final Timer _autoScrollTimer;
  static const int _infiniteLoopOffset = 1000;

  @override
  void initState() {
    super.initState();
    // Fraction so that `visibleCount` items (plus spacing) fit in view
    final fraction = 1 / widget.visibleCount;

    _pageController = PageController(
      viewportFraction: fraction,
      initialPage: widget.cards.length * _infiniteLoopOffset,
    );

    _autoScrollTimer = Timer.periodic(widget.autoChangeDuration, (_) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void didUpdateWidget(covariant HorizontalMovieCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    final fraction = 1 / widget.visibleCount;

    _pageController = PageController(
      viewportFraction: fraction,
      initialPage: widget.cards.length * _infiniteLoopOffset,
    );
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      // disable user scroll
      itemCount: widget.cards.length * _infiniteLoopOffset * 2,
      itemBuilder: (context, index) {
        final actualIndex = index % widget.cards.length;

        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            final page = _pageController.hasClients
                ? _pageController.page ?? _pageController.initialPage.toDouble()
                : _pageController.initialPage.toDouble();
            final distance = (page - index).abs().clamp(0.0, 1.0);

            // Interpolate scale between centerCardScale and 1.0
            final scale = lerpDouble(widget.centerCardScale, 1.0, distance)!;

            // Optional: fade side cards
            final opacity = lerpDouble(1.0, 0.5, distance)!;

            // Margin for spacing
            final horizontalMargin = widget.spacing / 2;

            return Center(
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: widget.cards[actualIndex],
        );
      },
    );
  }
}
