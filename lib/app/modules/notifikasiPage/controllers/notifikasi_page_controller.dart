import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/notifikasi_model.dart';

class NotifikasiPageController extends GetxController {
  var notifications = <NotifikasiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.assignAll([
      NotifikasiModel(
        icon: Icons.wb_sunny,
        iconColor: const Color(0xFF1456EA),
        title: 'Cuaca Cerah',
        description:
            'Siang ini cuaca diperkirakan cerah. Waktu terbaik untuk melaut!',
      ),
      NotifikasiModel(
        icon: Icons.warning,
        iconColor: Colors.orange,
        title: 'Peringatan Angin Kencang',
        description:
            'Kecepatan angin di area Anda diperkirakan mencapai 40 km/jam. Harap berhati-hati.',
      ),
      NotifikasiModel(
        icon: Icons.wb_sunny,
        iconColor: const Color(0xFF1456EA),
        title: 'Cuaca Cerah',
        description:
            'Siang ini cuaca diperkirakan cerah. Waktu terbaik untuk melaut!',
      ),
    ]);
  }
}
