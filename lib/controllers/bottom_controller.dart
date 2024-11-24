
import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/home/home_screen.dart';
import 'package:wallpaper_app/views/notifications/notifications.dart';
import 'package:wallpaper_app/views/profile/profile.dart';
import 'package:wallpaper_app/views/search/search.dart';


class BottomProvider extends ChangeNotifier {
  int currentIndex = 0;

  final List<Widget> pages = [
    Homescreen(), 
    const SearchScreen(), 
    const Notifications(), 
    const Profile(),
  ];

  void onTabTapped(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
