import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:packageku_refactor/image_to_base64/image_to_base64_view.dart';

class ImageToBase64Controller extends State<ImageToBase64View> {
  static late ImageToBase64Controller instance;
  late ImageToBase64View view;

  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String? base64String;

  // 📸 Ambil gambar dari galeri atau kamera
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      imageFile = File(pickedFile.path);
    });

    // 📤 Convert ke Base64
    final bytes = await File(pickedFile.path).readAsBytes();
    final base64 = base64Encode(bytes);

    setState(() {
      base64String = base64;
    });
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
