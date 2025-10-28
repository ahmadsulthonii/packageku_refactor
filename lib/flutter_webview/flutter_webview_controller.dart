import 'package:flutter/material.dart';
import 'package:packageku_refactor/flutter_webview/flutter_webview_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterWebviewController extends State<FlutterWebviewView> {
  static late FlutterWebviewController instance;
  late FlutterWebviewView view;
  late final WebViewController controller;
  int loadingProgress = 0;

  @override
  void initState() {
    instance = this;
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() => loadingProgress = progress);
          },
          onPageStarted: (url) {
            debugPrint('Mulai buka: $url');
          },
          onPageFinished: (url) {
            debugPrint('Selesai buka: $url');
            setState(() => loadingProgress = 100);
          },
          onWebResourceError: (error) {
            debugPrint('Terjadi error: $error');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
