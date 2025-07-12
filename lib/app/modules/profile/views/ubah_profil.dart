import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profil_controller.dart';

class UbahProfil extends StatelessWidget {
  const UbahProfil({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1456EA)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Informasi Diri",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(() {
                    print("✅ selectedImage: ${controller.selectedImage.value}");
                    print("✅ fotoProfil: ${controller.fotoProfil.value}");

                    ImageProvider imageProvider;

                    if (controller.selectedImage.value != null) {
                      imageProvider =
                          FileImage(controller.selectedImage.value!);
                    } else if (controller.fotoProfil.value.isNotEmpty) {
                      imageProvider = NetworkImage(
                        '${ApiConfig.baseUrl}/uploads/${controller.fotoProfil.value}?v=${DateTime.now().millisecondsSinceEpoch}',
                      );
                    } else {
                      imageProvider =
                          const AssetImage('assets/images/default_avatar.png');
                    }

                    return CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: imageProvider,
                    );
                  }),
                  Positioned(
                    child: GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt,
                            size: 20, color: Colors.black87),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Informasi data diri anda belum lengkap, lengkapi data diri anda untuk menikmati semua layanan Smartfishing.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            Obx(() => infoTile("E-Mail", controller.userEmail.value)),
            Obx(() => infoTile("Nama Lengkap", controller.userName.value)),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: controller.hapusAkun,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "HAPUS AKUN",
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: controller.uploadFotoProfil,
              icon: const Icon(Icons.upload, color: Colors.white),
              label: const Text("SIMPAN FOTO PROFIL",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1456EA),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoTile(String label, String value) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: TextButton(
          onPressed: () => onEditField(label),
          child: const Text(
            "UBAH",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1456EA),
            ),
          ),
        ),
      ),
    );
  }

  void onEditField(String label) {
    if (label == "E-Mail") {
      Get.snackbar(
        "Tidak Bisa Mengubah Email",
        "Perubahan email hanya dapat dilakukan melalui Customer Service",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else if (label == "Nama Lengkap") {
      Get.toNamed(Routes.EDIT_PROFILE_NAME);
    }
  }
}
