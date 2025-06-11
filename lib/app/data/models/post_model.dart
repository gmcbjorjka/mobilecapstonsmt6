class CommentModel {
  final String userId;
  final String nama;
  final String fotoProfil;
  final String komentar;
  final String createdAt;

  CommentModel({
    required this.userId,
    required this.nama,
    required this.fotoProfil,
    required this.komentar,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['user_id'],
      nama: json['nama'],
      fotoProfil: json['foto_profil'],
      komentar: json['komentar'],
      createdAt: json['created_at'],
    );
  }
}

class PostModel {
  final String id;
  final String userId;
  final String nama;
  final String fotoProfil;
  final String konten;
  final String createdAt;
  final List<CommentModel> komentar;

  PostModel({
    required this.id,
    required this.userId,
    required this.nama,
    required this.fotoProfil,
    required this.konten,
    required this.createdAt,
    required this.komentar,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      userId: json['user_id'],
      nama: json['nama'],
      fotoProfil: json['foto_profil'],
      konten: json['konten'],
      createdAt: json['created_at'],
      komentar: (json['komentar'] as List)
          .map((e) => CommentModel.fromJson(e))
          .toList(),
    );
  }
}
