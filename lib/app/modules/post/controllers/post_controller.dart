import 'package:get/get.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/post_service.dart';

class PostController extends GetxController {
  RxList<PostModel> posts = <PostModel>[].obs;

  // Ambil user dari Get.find
  final user = Get.find<UserModel>();

  // Simpan properti user dalam variabel observable
  late final RxString userid = user.id.obs;
  late final RxString userName = user.nama.obs;
  late final RxString fullName = user.email.obs;
  late final RxString userRole = user.role.obs;
  late final RxString fotoProfil = user.fotoProfil.obs;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  // Fungsi untuk memuat daftar post
  Future<void> loadPosts() async {
    try {
      final result = await PostService.getPosts();
      posts.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat post: $e");
    }
  }

  // Fungsi untuk membuat post baru
  Future<void> createPost(String konten) async {
    if (userid.value.isEmpty) {
      Get.snackbar("Gagal", "User belum login");
      return;
    }

    print("Posting oleh user: ${userid.value}");

    final success = await PostService.createPost(userid.value, konten);
    if (success) {
      await loadPosts();
      Get.snackbar("Sukses", "Post berhasil dibuat");
    } else {
      Get.snackbar("Gagal", "Post gagal dibuat");
    }
  }

  // Fungsi untuk menambahkan komentar ke post
  Future<void> addComment(String postId, String komentar) async {
    if (userid.value.isEmpty) {
      Get.snackbar("Gagal", "User belum login");
      return;
    }

    final success =
        await PostService.addComment(postId, userid.value, komentar);
    if (success) {
      await loadPosts();
    } else {
      Get.snackbar("Gagal", "Komentar gagal ditambahkan");
    }
  }
}
