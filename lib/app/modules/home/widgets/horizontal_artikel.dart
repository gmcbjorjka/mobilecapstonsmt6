import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/routes/app_pages.dart';
import '../../artikel/controllers/artikel_controller.dart';

class HorizontalArtikel extends StatelessWidget {
  const HorizontalArtikel({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtikelController controller = Get.find<ArtikelController>();

    return SizedBox(
      height: 150,
      child: Obx(() {
        final artikelList = controller.artikels;

        if (artikelList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: artikelList.length,
          itemBuilder: (context, index) {
            final artikel = artikelList[index];
            final judul = artikel.key;
            final data = artikel.value;

            return GestureDetector(
              onTap: () {
                final artikelData = {
                  'judul': judul, // tambahkan judul ke data
                  ...data, // gabungkan dengan data lainnya
                };
                Get.toNamed(Routes.ARTIKEL_DETAIL, arguments: artikelData);
              },
              child: Container(
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(data['gambar']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      judul,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
