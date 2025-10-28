import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:packageku_refactor/qr_code_scanner/qr_code_scanner_controller.dart';

class QRCodeScannerView extends StatefulWidget {
  const QRCodeScannerView({super.key});

  Widget build(context, QRCodeScannerController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => controller.controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => controller.controller.switchCamera(),
          ),
          IconButton(
            icon: const Icon(Icons.image),
            tooltip: 'Scan dari galeri',
            onPressed: controller.scanFromGallery,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: MobileScanner(
              controller: controller.controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  controller.setState(() {
                    controller.scannedData =
                        barcodes.first.rawValue ?? 'Tidak terbaca';
                  });
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Text(
                controller.scannedData ?? 'Arahkan kamera ke QR Code',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<QRCodeScannerView> createState() => QRCodeScannerController();
}
