import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:packageku_refactor/qr_code_scanner/qr_code_scanner_view.dart';

class QRCodeScannerController extends State<QRCodeScannerView> {
  static late QRCodeScannerController instance;
  late QRCodeScannerView view;

  String? scannedData;
  final MobileScannerController controller = MobileScannerController();

  Future<void> scanFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Scan QR dari gambar
    final result = await controller.analyzeImage(image.path);
    if (result != null) {
      setState(
        () => scannedData =
            (result.raw ?? 'Tidak ada data QR ditemukan') as String?,
      );
    } else {
      setState(() => scannedData = 'Gagal membaca QR dari gambar');
    }
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
