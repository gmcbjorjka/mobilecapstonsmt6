import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/user_service.dart';
import '../../../routes/app_pages.dart';

class ProfilController extends GetxController {
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userRole = ''.obs;
  final fotoProfil = ''.obs;
  final selectedImage = Rxn<File>();

  UserModel? get user =>
      Get.isRegistered<UserModel>() ? Get.find<UserModel>() : null;

  @override
  void onInit() {
    final u = user;
    userName.value = u?.nama ?? '';
    userEmail.value = u?.email ?? '';
    userRole.value = u?.role ?? '';
    fotoProfil.value = u?.fotoProfil ?? '';
    super.onInit();
  }

  String getRoleLabel(String roleId) {
    switch (roleId) {
      case '1':
        return 'Super Admin';
      case '2':
        return 'Admin';
      case '3':
        return 'User';
      default:
        return 'Tidak Diketahui';
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage.value = File(picked.path);
      // Simpan ke server atau local storage jika diperlukan
      Get.snackbar("Berhasil", "Foto profil berhasil dipilih");
    } else {
      Get.snackbar("Batal", "Tidak ada gambar yang dipilih");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await UserService.clearUserPrefs();

    try {
      await GoogleSignIn().signOut();
    } catch (_) {}

    if (Get.isRegistered<UserModel>()) {
      Get.delete<UserModel>();
    }

    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> hapusAkun() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await UserService.clearUserPrefs();

      if (Get.isRegistered<UserModel>()) {
        Get.delete<UserModel>();
      }

      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar(
        "Akun Dihapus",
        "Akun Anda berhasil dihapus",
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      Get.snackbar(
        "Gagal",
        "Gagal menghapus akun",
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}
