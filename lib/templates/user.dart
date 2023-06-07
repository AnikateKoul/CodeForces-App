class User {
  String handle;
  int rating;
  String rank;
  int contribution;
  String titlePhoto;
  int maxRating;
  String maxRank;
  int friendOfCount;

  User(this.handle, this.rating, this.rank, this.contribution, this.titlePhoto, this.maxRating, this.maxRank, this.friendOfCount);

  factory User.fromJson(dynamic json) {
    return User(json['handle'], json['rating'], json['rank'], json['contribution'], json['titlePhoto'], json['maxRating'], json['maxRank'], json['friendOfCount']);
  }

  @override
  String toString() {
    return '$handle, $rating, $rank, $contribution, $titlePhoto, $maxRating, $maxRank, $friendOfCount';
  }

}