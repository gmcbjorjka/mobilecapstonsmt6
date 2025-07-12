import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreamlitWebSection extends StatefulWidget {
  const StreamlitWebSection({super.key});

  @override
  State<StreamlitWebSection> createState() => _StreamlitWebSectionState();
}

class _StreamlitWebSectionState extends State<StreamlitWebSection> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse('https://49xbq6gkeuqe9izyau3peg.streamlit.app/'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
