import 'package:flutter/material.dart';
import 'package:mohamed_suliman_task3_itida/pages/home.dart';
void main(){
  runApp(const Task3());
}
class Task3 extends StatelessWidget {
  const Task3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
      home: HomeLand(),
    );
  }
}
