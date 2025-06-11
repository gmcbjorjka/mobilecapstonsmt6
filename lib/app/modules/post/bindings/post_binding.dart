import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../controllers/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<UserModel>()) {
      // Jangan load PostController dulu kalau user belum tersedia
      // Bisa kasih fallback atau handle dengan aman
    }
    Get.lazyPut<PostController>(
      () => PostController(),
    );
  }
}
