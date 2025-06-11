import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GantiKatasandiController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void changePassword() {
    final oldPass = oldPasswordController.text;
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (newPass != confirmPass) {
      Get.snackbar('Gagal', 'Kata sandi baru dan konfirmasi tidak cocok');
      return;
    }

    // TODO: Tambahkan logika validasi/koneksi API ke backend

    Get.snackbar('Berhasil', 'Kata sandi berhasil diubah');
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
