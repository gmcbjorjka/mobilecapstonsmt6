import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCodeController extends GetxController {
  final codeController = TextEditingController();
  final isLoading = false.obs;

  final email = ''.obs; // akan diisi dari parameter route

  void verifyCode() async {
    if (codeController.text.isEmpty) {
      Get.snackbar("Error", "Kode verifikasi harus diisi!");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1)); // simulasi

    isLoading.value = false;

    // Pindah ke halaman reset password, kirim email dan kode
    Get.toNamed('/reset-password', arguments: {
      'email': email.value,
      'kode': codeController.text,
    });
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('email')) {
      email.value = args['email'] ?? '';
    } else {
      email.value = '';
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
