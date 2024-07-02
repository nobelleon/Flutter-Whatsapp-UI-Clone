import 'package:flutter/material.dart';
import 'package:whatsapp_ui_app/beranda.dart';
import 'package:whatsapp_ui_app/screens/web_layout_screen.dart';
import 'package:whatsapp_ui_app/utils/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: Beranda(),
        webScreenLayout: WebLayoutScreen(),
      ),
    );
  }
}
