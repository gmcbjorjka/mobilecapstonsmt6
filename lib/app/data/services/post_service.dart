import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_config.dart';
import '../models/post_model.dart';

// Ganti IP sesuai server kamu

class PostService {
  static Future<List<PostModel>> getPosts() async {
    final res = await http.get(Uri.parse('${ApiConfig.baseUrl}/post'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)['data'] as List;
      return data.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat post');
    }
  }

  static Future<bool> createPost(String userId, String konten) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/post'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Jika perlu token
      },
      body: jsonEncode({
        'user_id': userId, // ← WAJIB ADA
        'konten': konten,
      }),
    );

    print("📦 response body: ${response.body}");

    return response.statusCode == 200;
  }

  static Future<bool> addComment(
      String postId, String userId, String komentar) async {
    final res = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/posts/$postId/komentar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'komentar': komentar}),
    );
    return res.statusCode == 200;
  }
}
