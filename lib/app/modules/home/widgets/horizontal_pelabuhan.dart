import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/routes/app_pages.dart';
import '../../pelabuhan/controllers/pelabuhan_controller.dart';

class HorizontalPelabuhan extends StatelessWidget {
  const HorizontalPelabuhan({super.key});

  @override
  Widget build(BuildContext context) {
    final PelabuhanController controller = Get.find<PelabuhanController>();

    return SizedBox(
      height: 150,
      child: Obx(() {
        final pelabuhanList = controller.destinations;

        if (pelabuhanList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pelabuhanList.length,
          itemBuilder: (context, index) {
            final pelabuhan = pelabuhanList[index];

            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.PELABUHAN_DETAIL, arguments: {
                  'title': pelabuhan.key,
                  'data': pelabuhan.value,
                });
              },
              child: Container(
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                        pelabuhan.value['image']), // Ganti AssetImage
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
                      pelabuhan.key,
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
