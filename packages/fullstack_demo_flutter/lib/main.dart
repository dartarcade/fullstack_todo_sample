import 'package:flutter/material.dart';
import 'package:fullstack_demo_flutter/core/di/di.dart';
import 'package:fullstack_demo_flutter/core/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router.config(),
    );
  }
}
