import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_db/src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } catch (e) {
    // Orientation lock is non-critical: proceed without it so the app still
    // launches instead of hanging on the native splash screen.
    debugPrint('Failed to set preferred orientations: $e');
  }
  runApp(const MyApp());
}
