import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/app_config.dart';

class ResetPasswordController extends GetxController {
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  late String email;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      email = args['email'] ?? '';
      codeController.text = args['kode'] ?? '';
    } else {
      email = '';
      codeController.text = '';
    }
  }

  void resetPassword() async {
    final code = codeController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (code.isEmpty || password.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "Semua kolom harus diisi!");
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Error", "Password minimal 6 karakter.");
      return;
    }

    if (password != confirm) {
      Get.snackbar("Error", "Password tidak cocok.");
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse("${ApiConfig.baseUrl}/user/reset-password");
      final response = await http.post(url, body: {
        "email": email,
        "kode": codeController.text.trim(),
        "password": passwordController.text.trim(),
      });

      isLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar("Sukses", "Password berhasil diubah.");
        // Hapus controller dulu
        // Get.delete<ResetPasswordController>();

        Get.toNamed('/login'); // Pindah ke halaman login
      } else {
        final msg = response.body;
        Get.snackbar("Gagal", "Reset password gagal: $msg");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  @override
  void onClose() {
    print("🗑️ ResetPasswordController dihapus");
    codeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
