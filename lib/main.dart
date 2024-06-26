import 'package:assignment/firebase_options.dart';
import 'package:assignment/screens/SplashScreen.dart';
import 'package:assignment/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await  NotificationService.initializeNotifications();
 runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home:const SplashScreen(),
    );
  }
}
