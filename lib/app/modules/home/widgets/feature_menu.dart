import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class FeatureMenu extends StatelessWidget {
  const FeatureMenu();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.directions_boat,
        'label': 'Pelabuhan',
        'gradient': LinearGradient(
            colors: [Color(0xFF64E9FF), Color(0xFF103CE7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
      },
      {
        'icon': Icons.article,
        'label': 'Artikel',
        'gradient': LinearGradient(
            colors: [Color(0xFFF6D242), Color(0xFFFF52E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
      },
      {
        'icon': Icons.info,
        'label': 'Detail Ikan',
        'gradient': LinearGradient(
            colors: [Color(0xFF0BA360), Color(0xFF3CBA92)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
      },
      {
        'icon': Icons.timeline,
        'label': 'Analisis',
        'gradient': LinearGradient(
            colors: [Color(0xFFFF7EB3), Color(0xFFFF758C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
      },
      {
        'icon': Icons.group,
        'label': 'Komunitas',
        'gradient': LinearGradient(
            colors: [Color(0xFFD6A3FB), Color(0xFF8E54E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                if (index == 0) {
                  Get.toNamed(Routes.PELABUHAN);
                } else if (index == 1) {
                  Get.toNamed(Routes.ARTIKEL);
                } else if (index == 2) {
                  Get.toNamed(Routes.IKANVIEW);
                } else if (index == 3) {
                  Get.toNamed(Routes.STREAMLIT_WEB);
                } else if (index == 4) {
                  Get.toNamed(Routes.POST);
                }
                // Bisa tambahkan else if untuk menu lain kalau mau
              },
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: feature['gradient'],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child:
                          Icon(feature['icon'], size: 30, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(feature['label']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
