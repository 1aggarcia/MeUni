class Uniing {
  String? id;
  final String title;
  final String desc;
  final String link;
  final String startTime;
  final String endTime;

  Uniing({
    this.id,
    required this.title,
    required this.desc,
    required this.link,
    required this.startTime,
    required this.endTime,
  });

  /// Creates an instance uni-ing from a json map.
  factory Uniing.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() => throw UnimplementedError();

  bool equals(Uniing other) {
    throw UnimplementedError();
  }
}

