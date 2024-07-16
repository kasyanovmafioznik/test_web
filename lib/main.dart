// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_task_web/generated/l10n.dart';
import 'package:test_task_web/screens/cart_page.dart';
import 'package:test_task_web/screens/log_in.dart';
import 'package:test_task_web/screens/main_catalog.dart';
import 'package:test_task_web/screens/profile.dart';
import 'package:test_task_web/screens/settings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  void _setLocale(String lang) {
    setState(() {
      _locale = Locale(lang);
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Shop',
      theme: _buildTheme(),
      home: MainCatalog(
        onSelectedLanguages: _setLocale,
        currentLang: _locale.languageCode,
      ),
      locale: _locale,
      routes: {
        '/catalog': (context) => MainCatalog(
              onSelectedLanguages: _setLocale,
              currentLang: _locale.languageCode,
            ),
          '/settings': (context) => const SettingsScreen(),
          '/login' : (context) => const LoginScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/cart' : (context) => const CartScreen(),
      },
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      useMaterial3: true,
      primaryColor: Colors.white,
      hintColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: const AppBarTheme(
        color: Color(0xFFF0F0F0),
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
