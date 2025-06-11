import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IkanDetailPage extends StatelessWidget {
  const IkanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String title = arguments['title'];
    final Map<String, dynamic> data = arguments['data'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1456EA)),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(data['imageUrl'], fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(data['description'],
                      style: const TextStyle(fontSize: 16)),
                  if (data.containsKey('scientificName')) ...[
                    const SizedBox(height: 12),
                    const Text('Nama Ilmiah:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(data['scientificName']),
                  ],
                  if (data.containsKey('habitat')) ...[
                    const SizedBox(height: 12),
                    const Text('Habitat:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(data['habitat']),
                  ],
                  if (data.containsKey('size')) ...[
                    const SizedBox(height: 12),
                    const Text('Ukuran Rata-rata:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(data['size']),
                  ],
                  if (data.containsKey('weight')) ...[
                    const SizedBox(height: 12),
                    const Text('Berat Rata-rata:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(data['weight']),
                  ],
                  if (data.containsKey('color')) ...[
                    const SizedBox(height: 12),
                    const Text('Warna:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(data['color']),
                  ],
                  if (data.containsKey('nutrition')) ...[
                    const SizedBox(height: 12),
                    const Text('Informasi Gizi:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Protein: ${data['nutrition']['protein']}'),
                    Text('Lemak: ${data['nutrition']['lemak']}'),
                    Text('Kalori: ${data['nutrition']['kalori']}'),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
