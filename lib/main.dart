import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';

/// Main entry point for the Trusted application
///
/// Uses DevicePreview in development for testing on different device sizes
void main() {
  runApp(
    DevicePreview(
      enabled: true,
      defaultDevice: Devices.ios.iPhone16ProMax,
      builder: (context) => const App(),
    ),
  );
}