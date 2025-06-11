import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/routes/app_pages.dart';
import '../../../data/ikan.dart';

class HorizontalIkan extends StatelessWidget {
  const HorizontalIkan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, Map<String, dynamic>>> ikanList =
        fishDetails.entries.toList();

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ikanList.length,
        itemBuilder: (context, index) {
          final ikan = ikanList[index];
          final data = ikan.value;

          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.IKAN_DETAIL, arguments: {
                'title': data['name'],
                'data': data,
              });
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green.shade50,
                image: DecorationImage(
                  image: AssetImage(data['imageUrl']),
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
                    data['name'],
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
      ),
    );
  }
}
