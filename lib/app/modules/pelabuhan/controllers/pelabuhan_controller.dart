import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/app_config.dart';

class PelabuhanController extends GetxController {
  final destinations = <MapEntry<String, Map<String, dynamic>>>[].obs;

// Ganti dengan IP Flask kamu

  @override
  void onInit() {
    fetchPelabuhan();
    super.onInit();
  }

  void fetchPelabuhan() async {
    try {
      final response =
          await http.get(Uri.parse('${ApiConfig.baseUrl}/pelabuhan'));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final List data = result['data'];

        final loaded = data.map((item) {
          return MapEntry<String, Map<String, dynamic>>(
            item['nama_pelabuhan'],
            {
              'image': '${ApiConfig.baseUrl}/uploads/${item['image']}',
              'description': item['description'],
              'location': item['location'],
              'rating': item['rating'],
              'facilities': item['facilities'],
              'article': item['article'],
            },
          );
        }).toList();

        destinations.assignAll(loaded);
      } else {
        print('Gagal mengambil data pelabuhan');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
