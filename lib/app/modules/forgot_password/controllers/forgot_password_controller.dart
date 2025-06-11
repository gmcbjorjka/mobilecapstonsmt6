import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/app_config.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  void sendResetCode() async {
    final email = emailController.text;

    if (email.isEmpty || !email.isEmail) {
      Get.snackbar("Error", "Masukkan email yang valid!");
      return;
    }

    isLoading.value = true;

    final url = Uri.parse(
        "${ApiConfig.baseUrl}/user/forgot-password"); // ganti IP jika pakai device
    final response = await http.post(url, body: {"email": email});

    isLoading.value = false;

    if (response.statusCode == 200) {
      Get.snackbar("Berhasil", "Kode reset dikirim ke email kamu!");
      Get.toNamed('/verify-code', arguments: {'email': email});
    } else {
      final error = response.body;
      Get.snackbar("Gagal", "Gagal mengirim email: $error");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
