import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:camera/camera.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';

class ResizableBox {
  double left;
  double top;
  double width;
  double height;

  ResizableBox({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });
}

class MeasurementController extends GetxController {
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  List<ResizableBox> boundingBoxes = [
    ResizableBox(left: 100, top: 150, width: 150, height: 150),
  ];

  bool showNotice = true;
  double fishDensity = 1.05;
  double totalWeight = 0.0;
  String fishType = "Nila";

  int get fishCount => boundingBoxes.length;

  @override
  void onInit() {
    super.onInit();
    initCamera();
    Future.delayed(const Duration(seconds: 5), () {
      showNotice = false;
      update();
    });
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    cameraController = CameraController(camera, ResolutionPreset.medium);
    initializeControllerFuture = cameraController.initialize();
    update();
  }

  void updateBox(int index, ResizableBox updated) {
    boundingBoxes[index] = updated;
    calculateWeight();
    update();
  }

  void removeBox(int index) {
    boundingBoxes.removeAt(index);
    calculateWeight();
    update();
  }

  void calculateWeight() {
    totalWeight = 0.0;
    for (var box in boundingBoxes) {
      double radius = (box.width / 2) * 0.1;
      double volume = (2 / 3) * pi * pow(radius, 3);
      totalWeight += volume * fishDensity;
    }
    totalWeight /= 1000;
  }

  Future<void> saveMeasurement() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        Get.snackbar("Gagal", "Token tidak ditemukan");
        return;
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/penimbangan'), // ganti jika di device
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "weight": totalWeight,
          "count": boundingBoxes.length,
          "fish_type": fishType,
          "created_at": DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Sukses", "Penimbangan disimpan");
        await Future.delayed(Duration(seconds: 1));
        Get.toNamed(Routes.MAIN_PAGE); // Ganti ke `Routes.MAIN_PAGE` jika ada
      } else {
        Get.snackbar(
            "Gagal", "Status ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
