import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohamed_suliman_task3_itida/pages/settings_page.dart';
import 'package:mohamed_suliman_task3_itida/services/api.dart';
import 'package:mohamed_suliman_task3_itida/utils/product_model.dart';

import 'cart_page.dart';
import 'home_page.dart';
class HomeLand extends StatefulWidget {

  const HomeLand({super.key});

  @override
  State<HomeLand> createState() => _HomeState();

}

class _HomeState extends State<HomeLand> {
  int indexNav = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white
      ),foregroundColor: Colors.black,backgroundColor: Colors.white,title: indexNav==0?
      Text("Home"):indexNav==1?
      Text("Products"):
      Text("Settings"),
        centerTitle: true,
        elevation: 5,),
      body: indexNav==0?const HomePage():indexNav==1? ProductsPage():const SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        onTap: (index){
          indexNav = index;
          setState(() {
          });
        },
        currentIndex: indexNav,
        items:const [
         BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
         BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart),label: "Cart"),
         BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
      ],),
    );
  }
}
