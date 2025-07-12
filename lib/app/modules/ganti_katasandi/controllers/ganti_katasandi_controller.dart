import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';

class GantiKatasandiController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void changePassword() async {
    final oldPass = oldPasswordController.text;
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (newPass != confirmPass) {
      Get.snackbar('Gagal', 'Kata sandi baru dan konfirmasi tidak cocok');
      return;
    }

    if (oldPass.isEmpty || newPass.isEmpty) {
      Get.snackbar('Gagal', 'Semua field harus diisi');
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/user/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'old_password': oldPass,
          'new_password': newPass,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        Get.snackbar(
            'Berhasil', data['message'] ?? 'Kata sandi berhasil diubah');

        // Bersihkan input
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        // Kembali ke halaman sebelumnya
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAllNamed(Routes.MAIN_PAGE);
        });
      } else {
        Get.snackbar('Gagal', data['message'] ?? 'Gagal mengubah kata sandi');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
