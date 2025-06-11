import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController();
  final showAppBar = false.obs;
  final user = Get.find<UserModel>();
  late final RxString userName = user.nama.obs;
  late final RxString fullName = user.email.obs;
  late final RxString userRole = user.role.obs;
  late final RxString fotoProfil = user.fotoProfil.obs;

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) {
      return 'Selamat Pagi';
    } else if (hour >= 11 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      checkScroll(scrollController.offset);
    });

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  void checkScroll(double offset) {
    if (offset > 50 && !showAppBar.value) {
      showAppBar.value = true;
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ));
    } else if (offset <= 50 && showAppBar.value) {
      showAppBar.value = false;
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ));
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void pusat_bantuan() {
    Get.snackbar('Info', 'Fitur belum tersedia');
  }
}
