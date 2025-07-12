import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/user_service.dart';
import '../../../config/app_config.dart';
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
    _loadUser();
    super.onInit();
  }

  void _loadUser() {
    final u = user;
    userName.value = u?.nama ?? '';
    userEmail.value = u?.email ?? '';
    userRole.value = u?.role ?? '';
    fotoProfil.value = u?.fotoProfil ?? '';
    print("📌 Loaded user: ${u?.nama}, fotoProfil: ${u?.fotoProfil}");
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage.value = File(picked.path);
      Get.snackbar("Berhasil", "Foto profil berhasil dipilih");
    } else {
      Get.snackbar("Batal", "Tidak ada gambar yang dipilih");
    }
  }

  Future<void> uploadFotoProfil() async {
    final file = selectedImage.value;
    if (file == null) {
      Get.snackbar("Gagal", "Silakan pilih gambar terlebih dahulu");
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final uri = Uri.parse('${ApiConfig.baseUrl}/user/upload-profile-picture');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final streamed = await request.send();
      final res = await http.Response.fromStream(streamed);

      print("✅ Status code: ${res.statusCode}");
      print("✅ Body: ${res.body}");

      final data = jsonDecode(res.body);

      if (res.statusCode == 200 && data['success'] == true) {
        Get.snackbar("Berhasil", "Foto profil berhasil diperbarui");

        final old = user;
        if (old != null && data['data'] != null) {
          final updated = old.copyWith(
            nama: data['data']['nama'],
            email: data['data']['email'],
            role: data['data']['role'],
            fotoProfil: data['data']['foto_profil'],
          );

          Get.delete<UserModel>();
          Get.put<UserModel>(updated);
          await UserService.saveUserToPrefs(updated);

          userName.value = updated.nama;
          userEmail.value = updated.email;
          userRole.value = updated.role;
          fotoProfil.value = updated.fotoProfil;

          print("📌 Updated fotoProfil: ${fotoProfil.value}");
          Get.offAllNamed(Routes.MAIN_PAGE);
        }

        selectedImage.value = null;
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal upload foto profil");
      }
    } catch (e) {
      print("❌ Upload error: $e");
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  Future<void> updateNamaLengkap(String namaBaru) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final res = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/user/update-name'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'nama': namaBaru}),
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200 && data['success'] == true) {
        final old = user;
        if (old != null) {
          final updated = old.copyWith(nama: data['data']['nama']);
          Get.delete<UserModel>();
          Get.put<UserModel>(updated);
          await UserService.saveUserToPrefs(updated);

          userName.value = updated.nama;

          Get.back();
          Get.snackbar("Berhasil", "Nama berhasil diperbarui");
        }
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal memperbarui nama");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
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
}
