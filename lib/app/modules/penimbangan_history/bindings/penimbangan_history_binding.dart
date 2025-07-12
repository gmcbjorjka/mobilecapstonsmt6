import 'package:get/get.dart';

import '../controllers/penimbangan_history_controller.dart';

class PenimbanganHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PenimbanganHistoryController>(
      () => PenimbanganHistoryController(),
    );
  }
}
