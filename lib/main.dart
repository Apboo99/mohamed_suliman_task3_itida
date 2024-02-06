import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_suliman_task3_itida/pages/home.dart';
import 'firebase_options.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
