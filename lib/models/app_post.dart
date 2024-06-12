class AppPost {
  String userName;
  String userId;
  String postId;
  String studentClub;
  String profileImage;
  String description;
  String postImage;
  int likes;
  bool liked = false;
  List<dynamic> comments;

  AppPost({
    required this.userId,
    required this.userName,
    required this.postId,
    required this.studentClub,
    required this.profileImage,
    required this.description,
    required this.postImage,
    required this.likes,
    required this.liked,
    required this.comments,
  });

  AppPost.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        userName = map['userName'],
        postId = map['postId'],
        studentClub = map['studentClub'],
        profileImage = map['profileImage'],
        description = map['description'],
        postImage = map['postImage'],
        likes = map['likes'],
        comments = map['comments'];
}
