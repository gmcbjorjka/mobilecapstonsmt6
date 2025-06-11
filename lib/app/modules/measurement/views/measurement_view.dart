import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../controllers/measurement_controller.dart';

class CameraView extends GetView<MeasurementController> {
  @override
  Widget build(BuildContext context) {
    // pastikan controller diinject
    final controller = Get.put(MeasurementController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penimbangan AI',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1456EA)),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<MeasurementController>(
        builder: (_) {
          return FutureBuilder(
            future: controller.initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(controller.cameraController);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
