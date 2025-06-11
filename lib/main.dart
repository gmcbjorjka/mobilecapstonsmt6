import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/models/user_model.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initUser();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
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
    await Get.putAsync<UserModel>(() async => user); // ⬅️ pastikan ini
    print("✅ UserModel dimuat: ${user.nama}");
  } else {
    print("❌ Tidak ada user disimpan");
  }
}
