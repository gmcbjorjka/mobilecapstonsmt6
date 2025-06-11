import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ikanview_controller.dart';
import 'ikan_detail.dart';

class IkanView extends GetView<IkanviewController> {
  const IkanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Ikan',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text('Jenis Ikan Populer',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final ikan = controller.ikanList;
                return ListView.builder(
                  itemCount: ikan.length,
                  itemBuilder: (context, index) {
                    final entry = ikan[index];
                    final title = entry.value['name'];
                    final data = entry.value;

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const IkanDetailPage(), arguments: {
                          'title': title,
                          'data': data,
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(data['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [Colors.black45, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
