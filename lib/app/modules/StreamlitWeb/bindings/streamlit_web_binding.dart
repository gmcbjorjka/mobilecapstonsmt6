import 'package:get/get.dart';

import '../controllers/streamlit_web_controller.dart';

class StreamlitWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreamlitWebController>(
      () => StreamlitWebController(),
    );
  }
}
