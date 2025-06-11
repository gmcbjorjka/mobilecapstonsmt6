import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profil_controller.dart';

class ProfileCard extends GetView<ProfilController> {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final foto = controller.fotoProfil.value;
      final userName = controller.userName.value;
      final userRole = controller.userRole.value;

      if (userName.isEmpty || userRole.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: foto.isNotEmpty
                    ? (foto.startsWith('http')
                        ? NetworkImage(foto)
                        : NetworkImage("${ApiConfig.baseUrl}/uploads/$foto"))
                    : const AssetImage('assets/images/default_profile.jpeg')
                        as ImageProvider,
              ),
              const SizedBox(height: 12),
              Text(userName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(controller.getRoleLabel(userRole),
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  if (controller.user != null) {
                    Get.toNamed(
                        Routes.EDIT_PROFILE); // ✅ Gunakan konstanta, lebih aman
                  } else {
                    Get.snackbar("Oops", "Data pengguna tidak ditemukan.",
                        backgroundColor: Colors.orange,
                        colorText: Colors.white);
                  }
                },
                icon: const Icon(Icons.person),
                label: const Text('Lihat Profil'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
