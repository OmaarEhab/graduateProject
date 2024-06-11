class AppUser {
  String userName;
  String userId;
  String email;
  String studentClub;
  String profileImage;
  String role;

  AppUser(
      {required this.userId,
      required this.userName,
      required this.email,
      required this.studentClub,
      required this.profileImage,
      required this.role});

  AppUser.fromMap(Map<dynamic, dynamic> map)
      : userId = map['userId'] ?? '',
        userName = map['userName'] ?? '',
        email = map['email'] ?? '',
        studentClub = map['studentClub'] ?? '',
        profileImage = map['profileImage'] ?? '',
        role = map['role'] ?? '';
}
