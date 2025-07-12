import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/app_config.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/user_service.dart';
import '../../../routes/app_pages.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;
  final isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    serverClientId:
        '737134731791-i6mb3kqu3hva6muped01htfki4pvcvjp.apps.googleusercontent.com',
  );

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  Future<String> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      return '${android.manufacturer} ${android.model} (Android ${android.version.release})';
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return '${ios.name} ${ios.model} (iOS ${ios.systemVersion})';
    } else {
      return 'Unknown Device';
    }
  }

  Future<void> login() async {
    if (isLoading.value) return;
    isLoading.value = true;

    final email = emailController.text.trim();
    final password = passwordController.text;
    final deviceInfo = await getDeviceInfo();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan Password harus diisi",
          snackPosition: SnackPosition.TOP);
      isLoading.value = false;
      return;
    }

    final result =
        await UserService.login(email, password, deviceInfo: deviceInfo);

    if (result['success']) {
      final user = result['user'] as UserModel;

      // Hapus user lama dan simpan user baru di GetX
      if (Get.isRegistered<UserModel>()) {
        Get.delete<UserModel>();
      }
      Get.put<UserModel>(user);

      // Simpan ke SharedPreferences (agar konsisten dengan loginWithGoogle)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(user.toJson()));
      await prefs.setString('token', user.token);

      Get.offAllNamed(Routes.MAIN_PAGE);
    } else {
      Get.snackbar(
        "Login Gagal",
        result['message'] ?? "Email atau password salah",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;

      await _googleSignIn.signOut(); // Paksa pilih akun ulang
      final account = await _googleSignIn.signIn();
      if (account == null) {
        Get.snackbar("Login Dibatalkan", "Login Google dibatalkan");
        return;
      }

      final googleAuth = await account.authentication;
      final idToken = googleAuth.idToken;

      print("📍 Google email: ${account.email}");
      print("📍 Google ID Token: $idToken");

      if (idToken == null) {
        Get.snackbar("Login Gagal", "Tidak dapat mengambil ID Token");
        return;
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/google/flutter'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_token': idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data);

        // Simpan ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));
        await prefs.setString('token', user.token);

        // Hapus user lama (jika ada) lalu daftarkan yang baru
        if (Get.isRegistered<UserModel>()) Get.delete<UserModel>();
        Get.put<UserModel>(user);

        Get.offAllNamed(Routes.MAIN_PAGE);
      } else {
        Get.snackbar("Login Gagal", "Autentikasi gagal: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void forgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  void goToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  @override
  void onInit() {
    super.onInit();
    _logoutAll(); // opsional bersihkan saat awal
  }

  void _logoutAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    try {
      await _googleSignIn.signOut();
    } catch (_) {}

    if (Get.isRegistered<UserModel>()) {
      Get.delete<UserModel>();
    }
  }
}
