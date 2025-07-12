import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../data/models/user_model.dart';
import '../../../data/services/user_service.dart';
import '../../artikel/controllers/artikel_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../pelabuhan/controllers/pelabuhan_controller.dart';
import '../../profile/controllers/profil_controller.dart';
import '../../penimbangan_history/controllers/penimbangan_history_controller.dart';
import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ Load user from SharedPreferences secara sinkron (tanpa await)
    SharedPreferences.getInstance().then((prefs) {
      final userString = prefs.getString('user');
      if (userString != null) {
        final userJson = jsonDecode(userString);
        final user = UserModel.fromJson(userJson);
        Get.put<UserModel>(user); // ✅ Synchronous registration
        print("✅ UserModel dimuat: ${user.nama}");
      } else {
        print("❌ Tidak ada user disimpan");
      }
    });

    // Register semua controller
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PelabuhanController>(() => PelabuhanController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<ArtikelController>(() => ArtikelController());
    Get.lazyPut<PenimbanganHistoryController>(
        () => PenimbanganHistoryController());
  }
}
