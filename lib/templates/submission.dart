import 'problem.dart';

class Submission {
  int id;
  Problem problem;
  String programmingLanguage;
  String? verdict;

  Submission({required this.id, required this.problem, required this.programmingLanguage, this.verdict});

  factory Submission.fromJson(dynamic json) {
    return Submission(id: json['id'], problem: Problem.fromJson(json['problem']), programmingLanguage: json['programmingLanguage'], verdict: json['verdict']);
  }
}