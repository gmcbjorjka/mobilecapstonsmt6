import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/app_config.dart';

class ArtikelController extends GetxController {
  final artikels = <MapEntry<String, Map<String, dynamic>>>[].obs;

  @override
  void onInit() {
    fetchArtikels();
    super.onInit();
  }

  void fetchArtikels() async {
    try {
      final response =
          await http.get(Uri.parse('${ApiConfig.baseUrl}/artikel'));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final List data = result['data'];

        final loaded = data.map((item) {
          return MapEntry<String, Map<String, dynamic>>(
            item['judul'],
            {
              'isi': item['isi'],
              'gambar': '${ApiConfig.baseUrl}/uploads/${item['gambar']}',
              'penulis': item['penulis'],
              'created_at': item['created_at'],
              'updated_at': item['updated_at'],
            },
          );
        }).toList();

        artikels.assignAll(loaded);
      } else {
        print('Gagal mengambil data artikel');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
