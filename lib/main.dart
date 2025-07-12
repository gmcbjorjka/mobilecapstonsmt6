import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/data/models/user_model.dart';
import 'app/routes/app_pages.dart';

late String initialRoute; // ⬅️ Tambahkan ini

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initUser(); // ⬅️ Inisialisasi user & tentukan initialRoute
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initialRoute, // ⬅️ Gunakan initialRoute yang dinamis
      getPages: AppPages.routes,
    ),
  );
}

Future<void> initUser() async {
  final prefs = await SharedPreferences.getInstance();
  final userString = prefs.getString('user');
  if (userString != null) {
    final userJson = jsonDecode(userString);
    final user = UserModel.fromJson(userJson);
    await Get.putAsync<UserModel>(() async => user);
    print("✅ UserModel dimuat: ${user.nama}");
    initialRoute = Routes.MAIN_PAGE; // ⬅️ Langsung ke halaman utama
  } else {
    print("❌ Tidak ada user disimpan");
    initialRoute = Routes.SPLASH1; // ⬅️ Masih masuk halaman splash/login
  }
}
