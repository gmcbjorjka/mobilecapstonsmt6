import 'package:get/get.dart';

import '../controllers/ikanview_controller.dart';

class IkanviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IkanviewController>(
      () => IkanviewController(),
    );
  }
}
