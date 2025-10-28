import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:packageku_refactor/image_to_base64/image_to_base64_controller.dart';

class ImageToBase64View extends StatefulWidget {
  const ImageToBase64View({super.key});

  Widget build(context, ImageToBase64Controller controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(title: const Text('Image to Base64')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.imageFile != null)
                Image.file(
                  controller.imageFile!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo),
                label: const Text('Pilih dari Galeri'),
                onPressed: () => controller.pickImage(ImageSource.gallery),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Ambil dari Kamera'),
                onPressed: () => controller.pickImage(ImageSource.camera),
              ),
              const SizedBox(height: 20),
              if (controller.base64String != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: SelectableText(
                      controller.base64String!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<ImageToBase64View> createState() => ImageToBase64Controller();
}
