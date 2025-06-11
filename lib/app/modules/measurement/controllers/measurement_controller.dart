import 'package:camera/camera.dart';
import 'package:get/get.dart';

class MeasurementController extends GetxController {
  //TODO: Implement MeasurementController

  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first; // kamera belakang
    cameraController = CameraController(camera, ResolutionPreset.medium);
    initializeControllerFuture = cameraController.initialize();
    update(); // memicu UI rebuild jika perlu
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
