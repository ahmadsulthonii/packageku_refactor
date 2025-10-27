import 'package:flutter/material.dart';
import 'package:packageku_refactor/date_time/date_time_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:packageku_refactor/home_page.dart';

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
        // '/dio': (context) => DioPackage(),
        // '/excel': (context) => ExportExcelPackage(),
        // '/webview': (context) => const FlutterWebviewPackage(
        //   url: 'https://flutter.dev',
        //   title: 'Flutter Website',
        // ),
        // '/geolocation': (context) => GeolocationPackage(),
        // '/imageCrop': (context) => ImageCropPackage(),
        // '/imagePicker': (context) => ImagePickerPackage(),
        // '/imageResize': (context) => ImageResizePackage(),
        // '/imageToBase64': (context) => ImageToBase64Package(),
        // '/notificationFcm': (context) => NotificationFcmPackage(),
        // '/notificationLocal': (context) => NotificationLocalPackage(),
        // '/permitionHandler': (context) => PermitionHandlerPackage(),
        // '/qrCode': (context) => QrCodeScannerPackage(),
        // '/sharePreference': (context) => SharePreferencePackage(),
      },
    );
  }
}
