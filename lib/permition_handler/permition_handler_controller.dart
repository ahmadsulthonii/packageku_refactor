import 'package:flutter/material.dart';
import 'package:packageku_refactor/permition_handler/permition_handler_view.dart';
import 'package:permission_handler/permission_handler.dart';

class PermitionHandlerController extends State<PermitionHandlerView> {
  static late PermitionHandlerController instance;
  late PermitionHandlerView view;
  String status = 'Belum ada izin diperiksa';

  /// Fungsi untuk meminta izin satu per satu
  Future<void> requestCameraPermission() async {
    var result = await Permission.camera.request();
    setState(() => status = 'Camera: $result');
  }

  Future<void> requestLocationPermission() async {
    var result = await Permission.location.request();
    setState(() => status = 'Location: $result');
  }

  Future<void> requestStoragePermission() async {
    var result = await Permission.storage.request();
    setState(() => status = 'Storage: $result');
  }

  Future<void> requestNotificationPermission() async {
    var result = await Permission.notification.request();
    setState(() => status = 'Notification: $result');
  }

  /// 🔄 Fungsi untuk meminta semua izin sekaligus
  Future<void> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
      Permission.notification,
    ].request();

    setState(() {
      status = statuses.entries.map((e) => '${e.key}: ${e.value}').join('\n');
    });
  }

  /// 🚪 Arahkan ke setting jika izin ditolak permanen
  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
