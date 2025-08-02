class ScriptEntry {
  final String text;
  final int startSec;
  final int endSec;
  final String imageRef;

  ScriptEntry({
    required this.text,
    required this.startSec,
    required this.endSec,
    required this.imageRef,
  });

  factory ScriptEntry.fromJson(Map<String, dynamic> json) {
    return ScriptEntry(
      text: json['text'],
      startSec: json['startSec'],
      endSec: json['endSec'],
      imageRef: json['imageRef'],
    );
  }
}
