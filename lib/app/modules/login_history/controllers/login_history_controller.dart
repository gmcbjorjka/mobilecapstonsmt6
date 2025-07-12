import 'package:get/get.dart';

import '../../../data/models/login_history_model.dart';
import '../../../data/services/user_service.dart';

class LoginHistoryController extends GetxController {
  var historyList = <LoginHistoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoginHistory();
  }

  void fetchLoginHistory() async {
    try {
      isLoading.value = true;
      final data = await UserService.getLoginHistory();
      historyList.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
