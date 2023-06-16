class Contest {
  int id;
  String name;
  String phase;
  int duration;
  int? startTime;

  Contest({required this.id, required this.name, required this.phase, required this.duration, this.startTime});

  factory Contest.fromJson(dynamic json) {
    return Contest(id: json["id"], name: json["name"], phase: json["phase"], duration: json["durationSeconds"], startTime: json["startTimeSeconds"]);
  }
}