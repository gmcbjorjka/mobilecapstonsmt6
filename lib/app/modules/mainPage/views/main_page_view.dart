import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/data/models/user_model.dart';
import 'package:mobile_capstone/app/data/services/user_service.dart';
import 'package:mobile_capstone/app/modules/artikel/controllers/artikel_controller.dart';
import 'package:mobile_capstone/app/modules/home/controllers/home_controller.dart';
import 'package:mobile_capstone/app/modules/pelabuhan/controllers/pelabuhan_controller.dart';
import 'package:mobile_capstone/app/modules/profile/controllers/profil_controller.dart';
import 'package:mobile_capstone/app/modules/measurement/views/measurement_view.dart';
import 'package:mobile_capstone/app/modules/pelabuhan/views/pelabuhan_view.dart';
import 'package:mobile_capstone/app/modules/home/views/home_view.dart';
import 'package:mobile_capstone/app/modules/profile/views/profile_view.dart';

import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _buildPage(controller.selectedIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) async {
            if (index == 1) {
              // Misal CameraView belum dibuat, ganti sesuai kebutuhan
              Get.to(() => CameraView());
            } else {
              controller.changePage(index);
            }
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _buildNavItem(Icons.home, 'Beranda', 0),
            _buildNavItem(Icons.straighten, 'Penimbangan AI', 1),
            _buildNavItem(Icons.directions_boat, 'Pelabuhan', 2),
            _buildNavItem(Icons.person, 'Profil', 3),
          ],
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showUnselectedLabels: true,
          elevation: 8,
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        if (!Get.isRegistered<HomeController>()) {
          Get.put(HomeController());
        }
        if (!Get.isRegistered<PelabuhanController>()) {
          Get.put(PelabuhanController());
        }
        if (!Get.isRegistered<ArtikelController>()) {
          Get.put(ArtikelController());
        }
        return const HomeView();

      case 1:
        return CameraView();

      case 2:
        if (!Get.isRegistered<PelabuhanController>()) {
          Get.put(PelabuhanController());
        }
        return const PelabuhanView();

      case 3:
        return FutureBuilder(
          future: _loadUserAndProfilController(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Terjadi kesalahan: ${snapshot.error}'));
            } else {
              return const ProfilView();
            }
          },
        );

      default:
        return const Center(child: Text('Halaman tidak ditemukan'));
    }
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    final isSelected = controller.selectedIndex.value == index;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isSelected ? 26 : 24,
            color: isSelected ? const Color(0xFF103CE7) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: isSelected ? 10 : 9,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
      label: '',
    );
  }

  Future<void> _loadUserAndProfilController() async {
    if (!Get.isRegistered<UserModel>()) {
      final user = await UserService.loadUserFromPrefs();
      if (user != null) {
        Get.put<UserModel>(user);
      } else {
        // Kalau tidak ada user, redirect ke login
        Get.offAllNamed('/login');
        return;
      }
    }

    if (!Get.isRegistered<ProfilController>()) {
      Get.put(ProfilController());
    }
  }
}
