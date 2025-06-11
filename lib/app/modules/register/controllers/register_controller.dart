import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final nameController = ''.obs;
  final emailController = ''.obs;
  final passwordController = ''.obs;
  final confirmPasswordController = ''.obs;

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  final String apiUrl =
      '${ApiConfig.baseUrl}/user/register'; // Ganti sesuai IP backend kamu

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void register() async {
    if (nameController.value.isEmpty ||
        emailController.value.isEmpty ||
        passwordController.value.isEmpty ||
        confirmPasswordController.value.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return;
    }

    if (passwordController.value != confirmPasswordController.value) {
      Get.snackbar('Error', 'Konfirmasi password tidak cocok');
      return;
    }

    isLoading.value = true;

    try {
      var uri = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields['nama'] = nameController.value;
      request.fields['email'] = emailController.value;
      request.fields['password'] = passwordController.value;

      // Tidak mengirim foto profil, jadi tidak perlu request.files

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200 && respJson['success'] == true) {
        Get.snackbar('Sukses', 'Registrasi berhasil');
        Get.offAllNamed(Routes.LOGIN); // Atur sesuai routing kamu
      } else {
        Get.snackbar('Gagal', respJson['message'] ?? 'Registrasi gagal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void signInWithGoogle() {
    Get.snackbar('Info', 'Fitur Google Sign In belum tersedia');
  }
}
