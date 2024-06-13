import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_project/firebase_options.dart';
import 'package:chatbot_project/pages/splash_screen.dart';
import 'package:chatbot_project/services/socket_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

  void main() async {
  HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisez la connexion Socket.IO via le service
    final SocketService socketService = SocketService();
    socketService.connect();

    // Obtenez la taille de l'écran
    final Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      home: SplashScreen(
          screenWidth: screenSize.width, screenHeight: screenSize.height),
    );
  }
}
