// lib/app/modules/profil/bindings/profil_binding.dart
import 'package:get/get.dart';
import 'package:mobile_capstone/app/modules/profile/controllers/profil_controller.dart';

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilController>(() => ProfilController());
  }
}
