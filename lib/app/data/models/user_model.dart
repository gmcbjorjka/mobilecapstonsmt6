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
      'id': id,
      'nama': nama,
      'email': email,
      'role': role,
      'foto_profil': fotoProfil,
      'token': token,
    };
  }

  UserModel copyWith({
    String? id,
    String? nama,
    String? email,
    String? role,
    String? fotoProfil,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      role: role ?? this.role,
      fotoProfil: fotoProfil ?? this.fotoProfil,
      token: token ?? this.token,
    );
  }
}
