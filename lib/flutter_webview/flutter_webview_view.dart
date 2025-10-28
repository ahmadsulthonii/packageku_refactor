import 'package:flutter/material.dart';
import 'package:packageku_refactor/flutter_webview/flutter_webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterWebviewView extends StatefulWidget {
  final String url; // bisa dikirim URL dinamis
  final String title;

  const FlutterWebviewView({
    super.key,
    required this.url,
    this.title = 'Web View',
  });

  Widget build(context, FlutterWebviewController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.widget.title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: controller.loadingProgress < 100
              ? LinearProgressIndicator(
                  value: controller.loadingProgress / 100,
                  backgroundColor: Colors.grey[200],
                  color: Colors.blueAccent,
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: WebViewWidget(controller: controller.controller),
      bottomNavigationBar: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                tooltip: 'Kembali',
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  if (await controller.controller.canGoBack()) {
                    await controller.controller.goBack();
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak ada halaman sebelumnya'),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                tooltip: 'Maju',
                icon: const Icon(Icons.arrow_forward),
                onPressed: () async {
                  if (await controller.controller.canGoForward()) {
                    await controller.controller.goForward();
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak ada halaman berikutnya'),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                tooltip: 'Muat ulang',
                icon: const Icon(Icons.refresh),
                onPressed: () => controller.controller.reload(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<FlutterWebviewView> createState() => FlutterWebviewController();
}
