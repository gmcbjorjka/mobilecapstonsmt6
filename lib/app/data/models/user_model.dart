class UserModel {
  final String id;
  final String nama;
  final String email;
  final String role;
  final String fotoProfil;
  final String token;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.role,
    required this.fotoProfil,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      fotoProfil: json['foto_profil'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nama': nama,
      'email': email,
      'role': role,
      'foto_profil': fotoProfil,
      'token': token,
    };
  }
}
