import 'package:asterflix/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(ProviderScope(
    child: const MyApp(),
  ));
}

class PlaybackStore {
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF6C5CE7),
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0E0E12),
      cardTheme: const CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
    );
    return MaterialApp.router(
      title: 'AsterFlix',
      theme: theme,
      routerConfig: router,
    );
  }
}
