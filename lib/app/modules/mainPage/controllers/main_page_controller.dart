import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/user_model.dart';

class MainPageController extends GetxController {
  var selectedIndex = 0.obs;
  final user = Get.find<UserModel>();
  late final RxString userName = user.nama.obs;
  late final RxString fullName = user.email.obs;
  late final RxString userRole = user.role.obs;
  late final RxString fotoProfil = user.fotoProfil.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    checkTokenAndScheduleLogout();
  }

  Future<void> checkTokenAndScheduleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || JwtDecoder.isExpired(token)) {
      Get.offAllNamed('/login');
    } else {
      final expirationDate = JwtDecoder.getExpirationDate(token);
      final remainingDuration = expirationDate.difference(DateTime.now());

      Future.delayed(remainingDuration, () async {
        // Auto logout saat token expired
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Get.offAllNamed('/login');
      });
    }
  }
}
