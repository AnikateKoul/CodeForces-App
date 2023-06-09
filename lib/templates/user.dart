class User {
  String handle;
  int contribution;
  String titlePhoto;
  int friendOfCount;
  int? rating;
  String? rank;
  int? maxRating;
  String? maxRank;

  User({required this.handle, required this.contribution, required this.titlePhoto, required this.friendOfCount, this.rating, this.rank, this.maxRating, this.maxRank});

  factory User.fromJson(dynamic json) {
    return User(handle: json['handle'], contribution: json['contribution'], titlePhoto: json['titlePhoto'], friendOfCount: json['friendOfCount'], rating: json['rating'], rank: json['rank'], maxRating: json['maxRating'], maxRank: json['maxRank']);
  }

}