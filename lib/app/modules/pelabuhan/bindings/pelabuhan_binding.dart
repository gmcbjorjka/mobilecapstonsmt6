import 'package:get/get.dart';

import '../controllers/pelabuhan_controller.dart';

class PelabuhanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PelabuhanController>(
      () => PelabuhanController(),
    );
  }
}
