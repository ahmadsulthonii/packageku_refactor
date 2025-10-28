import 'package:flutter/material.dart';
import 'package:packageku_refactor/date_time/date_time_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:packageku_refactor/export_excel/export_excel_view.dart';
import 'package:packageku_refactor/flutter_webview/flutter_webview_view.dart';
import 'package:packageku_refactor/geolocation/geolocation_view.dart';
import 'package:packageku_refactor/home_page.dart';
import 'package:packageku_refactor/image_crop/image_crop_view.dart';
import 'package:packageku_refactor/image_picker/image_picker_view.dart';
import 'package:packageku_refactor/image_resize/image_resize_view.dart';
import 'package:packageku_refactor/image_to_base64/image_to_base64_view.dart';
import 'package:packageku_refactor/permition_handler/permition_handler_view.dart';
import 'package:packageku_refactor/qr_code_scanner/qr_code_scanner_view.dart';
import 'package:packageku_refactor/share_preference/share_preference_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
      initialRoute: '/',
      routes: {
        '/dateTime': (context) => DateTimeView(),
        '/webview': (context) => const FlutterWebviewView(
          url: 'https://flutter.dev',
          title: 'Flutter Website',
        ),
        '/geolocation': (context) => GeolocationView(),
        '/sharePreference': (context) => SharePreferenceView(),
        '/permitionHandler': (context) => PermitionHandlerView(),
        '/qrCode': (context) => QRCodeScannerView(),
        '/imagePicker': (context) => ImagePickerView(),
        '/imageResize': (context) => ImageResizeView(),
        '/imageCrop': (context) => ImageCropView(),
        '/imageToBase64': (context) => ImageToBase64View(),
        '/excel': (context) => ExportExcelView(),
        // '/dio': (context) => DioPackage(),
        // '/notificationFcm': (context) => NotificationFcmPackage(),
        // '/notificationLocal': (context) => NotificationLocalPackage(),
      },
    );
  }
}
