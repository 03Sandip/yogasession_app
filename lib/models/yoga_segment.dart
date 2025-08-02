import 'script_entry.dart';

class YogaSegment {
  final String type; // "segment" or "loop"
  final String name;
  final String audioRef;
  final int duration;
  final int? iterations; // only for loop
  final bool? loopable;
  final List<ScriptEntry> script;

  YogaSegment({
    required this.type,
    required this.name,
    required this.audioRef,
    required this.duration,
    this.iterations,
    this.loopable,
    required this.script,
  });

  factory YogaSegment.fromJson(Map<String, dynamic> json) {
    return YogaSegment(
      type: json['type'],
      name: json['name'],
      audioRef: json['audioRef'],
      duration: json['durationSec'],
      iterations: json['iterations'] is int ? json['iterations'] : null,
      loopable: json['loopable'] is bool ? json['loopable'] : null,
      script: (json['script'] as List)
          .map((item) => ScriptEntry.fromJson(item))
          .toList(),
    );
  }
}
