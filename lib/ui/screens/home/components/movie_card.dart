import 'package:flutter/material.dart';
import 'package:reevie_web/extensions/context_extension.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String image;
  final Color color;

  const MovieCard({
    super.key,
    required this.title,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            spreadRadius: 10,
            blurRadius: 30,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        height: context.mW < 800 ? context.mW * 0.6 : context.mW * 0.3,
        width: context.mW < 800 ? context.mW * 0.3 : context.mW * 0.15,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ),
    );
  }
}
