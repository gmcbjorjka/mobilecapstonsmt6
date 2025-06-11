import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profil_controller.dart';
import '../widgets/menu_item.dart';
import '../widgets/profil_card.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 180),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Transform.translate(
                    offset: const Offset(0, -60), // Geser ke atas 60px
                    child: const ProfileCard(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      MenuItem(
                        icon: Icons.lock_outline,
                        title: 'Ganti Kata Sandi',
                        onTap: () => Get.toNamed(Routes.GANTI_KATASANDI),
                      ),
                      MenuItem(
                        icon: Icons.help_outline,
                        title: 'Pusat Bantuan',
                        onTap: () {
                          Get.toNamed(Routes.BANTUAN);
                        },
                      ),
                      MenuItem(
                        icon: Icons.logout,
                        title: 'Keluar',
                        onTap: controller.logout,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
