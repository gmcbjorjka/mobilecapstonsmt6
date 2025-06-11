import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_config.dart';
import '../controllers/post_controller.dart';
// untuk baseUrl

class PostView extends GetView<PostController> {
  final _kontenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.loadPosts(); // Load di awal

    return Scaffold(
      appBar: AppBar(title: const Text("Postingan")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _kontenController,
                    decoration:
                        const InputDecoration(hintText: 'Tulis sesuatu...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    controller.createPost(_kontenController.text);
                    _kontenController.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    final foto = post.fotoProfil;

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundImage: foto.isNotEmpty
                              ? (foto.startsWith('http')
                                  ? NetworkImage(foto)
                                  : NetworkImage(
                                      "${ApiConfig.baseUrl}/uploads/$foto"))
                              : const AssetImage(
                                      'assets/images/default_profile.jpeg')
                                  as ImageProvider,
                        ),
                        title: Text(post.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.konten),
                            const SizedBox(height: 6),
                            CommentInput(postId: post.id),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}

class CommentInput extends StatelessWidget {
  final String postId;
  final _commentController = TextEditingController();

  CommentInput({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _commentController,
            decoration: const InputDecoration(hintText: 'Komentar...'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            controller.addComment(postId, _commentController.text);
            _commentController.clear();
          },
        ),
      ],
    );
  }
}
