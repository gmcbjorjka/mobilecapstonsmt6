import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreamlitWebController extends GetxController {
  final isLoading = true.obs;
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isLoading.value = true;
          },
          onPageFinished: (url) {
            isLoading.value = false;
          },
          onWebResourceError: (error) {
            isLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://49xbq6gkeuqe9izyau3peg.streamlit.app/'));
  }
}
