import 'yoga_segment.dart';

class YogaSession {
  final String id;
  final String title;
  final String category;
  final int loopCount;
  final String tempo;
  final Map<String, String> images;
  final Map<String, String> audios;
  final List<YogaSegment> sequence;

  YogaSession({
    required this.id,
    required this.title,
    required this.category,
    required this.loopCount,
    required this.tempo,
    required this.images,
    required this.audios,
    required this.sequence,
  });

  factory YogaSession.fromJson(Map<String, dynamic> json) {
    return YogaSession(
      id: json['metadata']['id'],
      title: json['metadata']['title'],
      category: json['metadata']['category'],
      loopCount: json['metadata']['defaultLoopCount'],
      tempo: json['metadata']['tempo'],
      images: Map<String, String>.from(json['assets']['images']),
      audios: Map<String, String>.from(json['assets']['audio']),
      sequence: (json['sequence'] as List)
          .map((item) => YogaSegment.fromJson(item))
          .toList(),
    );
  }
}
