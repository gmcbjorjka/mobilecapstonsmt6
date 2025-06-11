import 'package:get/get.dart';

class Splash1Controller extends GetxController {
  //TODO: Implement Splash1Controller
  void goToNextSplash() {
    Get.toNamed('/splash2'); // atau gunakan Routes.SPLASH2 jika impor route
  }
}
