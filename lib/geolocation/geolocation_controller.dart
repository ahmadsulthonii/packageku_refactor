import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:packageku_refactor/geolocation/geolocation_view.dart';

class GeolocationController extends State<GeolocationView> {
  static late GeolocationController instance;
  late GeolocationView view;
  String locationMessage = "Tekan tombol untuk mendapatkan lokasi";

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Periksa apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Layanan lokasi tidak aktif";
      });
      return;
    }

    // 2. Periksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Izin lokasi ditolak";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage =
            "Izin lokasi ditolak permanen. Aktifkan dari pengaturan.";
      });
      return;
    }

    // 3. Ambil lokasi sekarang

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // update setiap 10 meter
      ),
    ).listen((Position position) {
      if (!mounted) return;

      setState(() {
        locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    });

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // update setiap 10 meter
      ),
    ).listen((Position position) {
      ('${position.latitude}, ${position.longitude}');
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
