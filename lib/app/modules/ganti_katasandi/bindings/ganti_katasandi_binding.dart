import 'package:get/get.dart';

import '../controllers/ganti_katasandi_controller.dart';

class GantiKatasandiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GantiKatasandiController>(
      () => GantiKatasandiController(),
    );
  }
}
