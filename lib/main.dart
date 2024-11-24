import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/bottom_controller.dart';
import 'package:wallpaper_app/controllers/image_controller.dart';
import 'package:wallpaper_app/views/bottombar/bottombar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ImageController(),
        ),
        ChangeNotifierProvider(create: (context)=> BottomProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavBar()
      ),
    );
  }
}
