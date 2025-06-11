import 'package:get/get.dart';

import '../../../routes/app_pages.dart'; // Sesuaikan path jika berbeda

class Splash2Controller extends GetxController {
  Future<void> checkAuth() async {
    Get.offAllNamed(Routes.LOGIN);
  }

  void startApp() {
    checkAuth();
  }
}
