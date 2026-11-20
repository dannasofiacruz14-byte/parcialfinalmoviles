import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'services/notification_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const CovidApp());
}

class CovidApp extends StatelessWidget {
  const CovidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Datos COVID-19',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}