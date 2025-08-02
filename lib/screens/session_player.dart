import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/yoga_session.dart';
import '../models/yoga_segment.dart';
import '../models/script_entry.dart';
import '../services/session_loader.dart';

class SessionPlayer extends StatefulWidget {
  const SessionPlayer({super.key});

  @override
  State<SessionPlayer> createState() => _SessionPlayerState();
}

class _SessionPlayerState extends State<SessionPlayer> {
  YogaSession? session;
  int currentSegmentIndex = 0;
  int currentScriptIndex = 0;
  int currentLoop = 0;

  final AudioPlayer _player = AudioPlayer();
  Timer? _scriptTimer;

  bool isPlaying = false;
  bool isPaused = false;
  Duration currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final loadedSession =
        await SessionLoader.loadFromAssets('assets/poses.json');
    setState(() {
      session = loadedSession;
    });
  }

  void _startSession() async {
    setState(() {
      isPlaying = true;
      isPaused = false;
      currentSegmentIndex = 0;
      currentScriptIndex = 0;
      currentLoop = 0;
      currentPosition = Duration.zero;
    });
    await _playSegment();
  }

  void _pauseSession() async {
    setState(() {
      isPlaying = false;
      isPaused = true;
    });
    currentPosition = await _player.getCurrentPosition() ?? Duration.zero;
    _scriptTimer?.cancel();
    await _player.pause();
  }

  void _resumeSession() async {
    setState(() {
      isPlaying = true;
      isPaused = false;
    });
    final segment = session!.sequence[currentSegmentIndex];
    final String audioFile = session!.audios[segment.audioRef]!;
    await _player.play(
      AssetSource('audio/$audioFile'),
      position: currentPosition,
    );
    _monitorScriptProgress(segment);
  }

  void _monitorScriptProgress(YogaSegment segment) {
    final List<ScriptEntry> scripts = segment.script;

    _scriptTimer?.cancel();
    _scriptTimer =
        Timer.periodic(const Duration(milliseconds: 300), (timer) async {
      if (!isPlaying || isPaused) return;

      final pos = await _player.getCurrentPosition() ?? Duration.zero;

      for (int i = 0; i < scripts.length; i++) {
        final entry = scripts[i];
        final start = Duration(seconds: entry.startSec);
        final end = Duration(seconds: entry.endSec);

        if (pos >= start && pos < end && currentScriptIndex != i) {
          setState(() {
            currentScriptIndex = i;
          });
          break;
        }
      }

      final totalDuration = await _player.getDuration() ?? Duration.zero;
      if (pos >= totalDuration) {
        timer.cancel();

        if (segment.type == "loop" &&
            currentLoop + 1 < (session?.loopCount ?? 1)) {
          currentLoop++;
          currentScriptIndex = 0;
          currentPosition = Duration.zero;
          await _player.play(
              AssetSource('audio/${session!.audios[segment.audioRef]!}'));
          _monitorScriptProgress(segment);
        } else {
          currentLoop = 0;
          currentSegmentIndex++;
          currentScriptIndex = 0;
          currentPosition = Duration.zero;

          if (currentSegmentIndex < session!.sequence.length) {
            await _playSegment();
          } else {
            setState(() {
              isPlaying = false;
              isPaused = false;
            });

            if (context.mounted) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Session Complete'),
                  content: const Text(
                      'You have successfully completed the yoga session.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          }
        }
      }
    });
  }

  Future<void> _playSegment() async {
    if (session == null || currentSegmentIndex >= session!.sequence.length) {
      return;
    }

    final YogaSegment segment = session!.sequence[currentSegmentIndex];
    final String audioFile = session!.audios[segment.audioRef]!;

    await _player.stop();
    currentScriptIndex = 0;
    currentPosition = Duration.zero;

    await _player.play(AssetSource('audio/$audioFile'));
    _monitorScriptProgress(segment);
  }

  @override
  void dispose() {
    _player.dispose();
    _scriptTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (currentSegmentIndex >= session!.sequence.length) {
      return Scaffold(
        appBar: AppBar(title: Text(session!.title)),
        body: const Center(
          child: Text(
            'Session Complete!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }

    final YogaSegment segment = session!.sequence[currentSegmentIndex];
    final List<ScriptEntry> scripts = segment.script;
    final entry = currentScriptIndex < scripts.length
        ? scripts[currentScriptIndex]
        : scripts.last;
    final String imageFile = session!.images[entry.imageRef]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(session!.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Image.asset('assets/images/$imageFile')),
            const SizedBox(height: 20),
            Text(
              entry.text,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Removed Previous Button
                if (!isPlaying && !isPaused)
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 36,
                    onPressed: _startSession,
                  )
                else if (isPaused)
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 36,
                    onPressed: _resumeSession,
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 36,
                    onPressed: _pauseSession,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
