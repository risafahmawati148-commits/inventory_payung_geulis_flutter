class UserModel {
  final int id;
  final String nama;
  final String email;
  final String token;

  static UserModel? currentUser;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    this.token = "",
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: json["id"] ?? 0,
      nama: json["nama"] ?? "",
      email: json["email"] ?? "",
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "email": email,
      "token": token,
    };
  }
}
