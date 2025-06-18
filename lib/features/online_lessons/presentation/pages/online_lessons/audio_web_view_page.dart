import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AudioWebViewPage extends StatelessWidget {
  final String url;

  const AudioWebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Audio"), backgroundColor: Colors.white),
      body: WebViewWidget(controller: controller,),
    );
  }
}
