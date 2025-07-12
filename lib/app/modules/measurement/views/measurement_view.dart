import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../controllers/measurement_controller.dart';

class CameraView extends GetView<MeasurementController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MeasurementController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Penimbangan Ikan'),
        backgroundColor: Color(0xFF1456EA),
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<MeasurementController>(
        builder: (_) {
          return FutureBuilder(
            future: controller.initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    CameraPreview(controller.cameraController),

                    // Bounding Boxes
                    ...controller.boundingBoxes.asMap().entries.map((entry) {
                      final i = entry.key;
                      final box = entry.value;

                      return Positioned(
                        left: box.left,
                        top: box.top,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            controller.updateBox(
                              i,
                              ResizableBox(
                                left: box.left + details.delta.dx,
                                top: box.top + details.delta.dy,
                                width: box.width,
                                height: box.height,
                              ),
                            );
                          },
                          onDoubleTap: () => controller.removeBox(i),
                          child: Stack(
                            children: [
                              Container(
                                width: box.width,
                                height: box.height,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    controller.updateBox(
                                      i,
                                      ResizableBox(
                                        left: box.left,
                                        top: box.top,
                                        width: (box.width + details.delta.dx)
                                            .clamp(50, 500),
                                        height: (box.height + details.delta.dy)
                                            .clamp(50, 500),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.open_in_full,
                                      size: 20, color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    // Notice
                    if (controller.showNotice)
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.yellow[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Geser atau ubah ukuran box.\nDobel tap untuk hapus.\nJarak ideal kamera: 5 meter.',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    // Info & Button - FIXED TO BOTTOM
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, -2),
                            )
                          ],
                        ),
                        child: SafeArea(
                          top: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Berat Total: ${controller.totalWeight.toStringAsFixed(2)} kg",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Jumlah Ikan: ${controller.fishCount}"),
                              Text("Jenis Ikan: ${controller.fishType}"),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: controller.saveMeasurement,
                                icon: const Icon(Icons.save),
                                label: const Text("Simpan & Kembali"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1456EA),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
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
