import 'package:flutter/material.dart';

class SessionControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onResume;

  const SessionControls({
    super.key,
    required this.isPlaying,
    required this.onPlay,
    required this.onPause,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isPlaying)
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: onPlay,
            iconSize: 36,
          )
        else ...[
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: onPause,
            iconSize: 36,
          ),
          IconButton(
            icon: const Icon(Icons.play_circle_fill),
            onPressed: onResume,
            iconSize: 36,
          ),
        ]
      ],
    );
  }
}
