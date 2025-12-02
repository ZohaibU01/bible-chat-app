class UserModel {
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userphoto;
  final String? userAgeRange;
  final String? userDenomination;
  final String? userChurch;

  UserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userphoto,
    this.userAgeRange,
    this.userDenomination,
    this.userChurch,
  });

  factory UserModel.loginfromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['name'],
      userEmail: json['email'],
      userId: json['id'],
    );
  }
factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    userName: json['name'] ?? '', // Default to empty string if 'name' is null
    userEmail: json['email'] ?? '', // Default to empty string if 'user_id' is null
    userId: json['userId'] ?? 0, // Default to 0 if 'id' is null
    userAgeRange: json['dateRange'] ?? '', // Default to empty string if 'dateRange' is null
    userChurch: json['church'] ?? '', // Default to empty string if 'church' is null
    userDenomination: json['denomination'] ?? '', // Default to empty string if 'denomination' is null
    userphoto: json['profile_picture'] ?? '', // Default to empty string if 'profile_picture' is null
  );
}


  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userId': userId,
    };
  }
}
