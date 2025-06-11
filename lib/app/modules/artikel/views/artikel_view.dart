import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/modules/artikel/controllers/artikel_controller.dart';
import 'package:mobile_capstone/app/routes/app_pages.dart';

class ArtikelPage extends StatelessWidget {
  final ArtikelController controller = Get.put(ArtikelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Artikel Menarik',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1456EA),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.artikels.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.artikels.length,
          itemBuilder: (context, index) {
            final artikel = controller.artikels[index];
            final data = artikel.value;
            return _buildArtikelCard(
              artikel.key,
              data['isi'],
              data['gambar'],
              data['penulis'],
              data,
            );
          },
        );
      }),
    );
  }

  Widget _buildArtikelCard(
    String title,
    String description,
    String imageUrl,
    String penulis,
    Map<String, dynamic> fullData,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ARTIKEL_DETAIL, arguments: {
          'judul': title,
          ...fullData,
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    penulis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description.length > 100
                        ? '${description.substring(0, 100)}...'
                        : description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Baca Selengkapnya →',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
