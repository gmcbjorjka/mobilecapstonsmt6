import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../config/app_config.dart';
import '../../../data/models/user_model.dart';

class PenimbanganHistoryController extends GetxController {
  var historiData = <Map<String, dynamic>>[].obs;
  var bobotPerHari = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      final user = Get.find<UserModel>();
      final token = user.token;

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/penimbangan'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        final data = jsonBody['data'] as List;

        historiData.assignAll(data.map((e) {
          final rawDate = e['created_at'] ?? e['tanggal'];
          final parsedDate =
              DateTime.tryParse(rawDate.toString()) ?? DateTime.now();

          final rawWeight = e['weight'];
          final weight = rawWeight is num
              ? rawWeight.toDouble()
              : double.tryParse(rawWeight.toString()) ?? 0.0;

          final rawCount = e['count'];
          final count = rawCount is int
              ? rawCount
              : int.tryParse(rawCount.toString()) ?? 0;

          return {
            'tanggal': parsedDate.toIso8601String(),
            'bobot': weight,
            'jumlah_ikan': count,
            'lokasi': e['lokasi'] ?? '-',
            'jenis_ikan': e['fish_type'] ?? '',
          };
        }).toList());

        _groupBobotPerTanggal();
      } else {
        print("❌ Gagal mengambil histori: ${response.body}");
      }
    } catch (e) {
      print("❌ Error histori: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _groupBobotPerTanggal() {
    final Map<String, double> grouped = {};

    for (var item in historiData) {
      final dateStr = item['tanggal'];
      final date = DateTime.tryParse(dateStr);
      if (date == null) continue;

      final hari = DateFormat('yyyy-MM-dd').format(date);
      final bobot = (item['bobot'] as num?)?.toDouble() ?? 0.0;

      grouped.update(hari, (val) => val + bobot, ifAbsent: () => bobot);
    }

    final sortedDates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    final latest7 = sortedDates.take(7).toList().reversed;

    bobotPerHari.assignAll(latest7.map((tgl) {
      final shortFormat = DateFormat('dd/MM').format(DateTime.parse(tgl));
      return {
        'tanggal': shortFormat,
        'bobot': grouped[tgl],
      };
    }));
  }
}
