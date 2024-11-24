import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/bottom_controller.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomProvider>(
      builder: (context, bottomProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: bottomProvider.pages[bottomProvider.currentIndex],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30), // Fully rounded corners
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white, // Semi-transparent background
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      height: 60,
                      width: 250,
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.transparent, // Transparent for rounded background
                        selectedItemColor: Colors.red,
                        unselectedItemColor: Colors.grey,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        currentIndex: bottomProvider.currentIndex,
                        onTap: (index) {
                          bottomProvider.onTabTapped(index);
                        },
                        items:  [
                          BottomNavigationBarItem(
                            icon: Image.asset('assets/pintrest.png',height: 20,),
                            label: "",
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.search,color: Color.fromARGB(255, 53, 51, 51),),
                            label: "",
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.notifications,color: Color.fromARGB(255, 53, 51, 51),),
                            label: "",
                          ),
                          const BottomNavigationBarItem(
                            
                            icon: Icon(Icons.person,color: Color.fromARGB(255, 53, 51, 51),),
                            label: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
