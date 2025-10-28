import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:packageku_refactor/geolocation/geolocation_controller.dart';

class GeolocationView extends StatefulWidget {
  const GeolocationView({super.key});

  Widget build(context, GeolocationController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(title: const Text("Geolocation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(controller.locationMessage, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.getCurrentLocation,
              child: const Text("Dapatkan Lokasi Sekarang"),
            ),
            ElevatedButton(
              onPressed: () {
                Geolocator.openLocationSettings();
              },
              child: Text('Buka setting'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<GeolocationView> createState() => GeolocationController();
}
