import 'package:flutter/material.dart';

class SessionProgressBar extends StatelessWidget {
  final double progress;

  const SessionProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 6,
        ),
      ),
    );
  }
}
