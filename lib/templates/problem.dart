class Problem {
  String name;
  int? contestId;
  String? index;
  int? rating;

  Problem({required this.name, this.contestId, this.index, this.rating});

  factory Problem.fromJson(dynamic json) {
    return Problem(name: json['name'], contestId: json['contestId'], index: json['index'], rating: json['rating']);
  }
}