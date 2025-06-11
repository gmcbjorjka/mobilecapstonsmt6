import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PelabuhanDetailPage extends StatelessWidget {
  const PelabuhanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String title = arguments['title'];
    final Map<String, dynamic> data = arguments['data'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1456EA),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dari URL Flask
            Image.network(
              data['image'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['description'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text('Lokasi: ${data['location']}'),
                  Text('Rating: ${data['rating']} ⭐'),
                  const SizedBox(height: 12),
                  const Text(
                    'Fasilitas:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...List<Widget>.from(
                    (data['facilities'] as List)
                        .map((fasilitas) => Text('- $fasilitas')),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sejarah / Artikel:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['article']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
