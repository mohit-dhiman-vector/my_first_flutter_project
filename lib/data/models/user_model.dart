class UserModel {
  final int? id;
  final String token;

  UserModel({this.id, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'], // present only in register
      token: json['token'],
    );
  }
}
