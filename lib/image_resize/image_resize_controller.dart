import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:packageku_refactor/image_resize/image_resize_view.dart';
import 'package:path_provider/path_provider.dart';

class ImageResizeController extends State<ImageResizeView> {
  static late ImageResizeController instance;
  late ImageResizeView view;

  File? originalImage;
  File? resizedImage;

  Future<void> pickAndResizeImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final file = File(picked.path);
    setState(() => originalImage = file);

    // Baca gambar sebagai bytes
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) return;

    // Resize (contoh: lebar 300px, tinggi menyesuaikan proporsi)
    final resized = img.copyResize(image, width: 300);

    // Simpan hasil resize
    final dir = await getApplicationDocumentsDirectory();
    final resizedFile = File('${dir.path}/resized_image.jpg')
      ..writeAsBytesSync(img.encodeJpg(resized, quality: 90));

    if (!mounted) return;

    setState(() => resizedImage = resizedFile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Gambar berhasil di-resize dan disimpan ke: ${resizedFile.path}',
        ),
      ),
    );
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
