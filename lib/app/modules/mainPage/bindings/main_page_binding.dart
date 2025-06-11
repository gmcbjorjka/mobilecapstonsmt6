import 'package:get/get.dart';
import 'package:mobile_capstone/app/modules/artikel/controllers/artikel_controller.dart';
import 'package:mobile_capstone/app/modules/home/controllers/home_controller.dart';
import 'package:mobile_capstone/app/modules/pelabuhan/controllers/pelabuhan_controller.dart';
import 'package:mobile_capstone/app/modules/profile/controllers/profil_controller.dart';

import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    // Load user secara sinkron

    // Register semua controller
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PelabuhanController>(() => PelabuhanController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<ArtikelController>(() => ArtikelController());
  }
}
