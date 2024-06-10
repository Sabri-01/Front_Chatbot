import 'package:chatbot_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key, required this.screenWidth, required this.screenHeight});
  final double screenWidth;
  final double screenHeight;


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(screenWidth: widget.screenWidth, screenHeight: widget.screenHeight)),
      );
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_uphf.png'),
            const SizedBox(height: 20), 
            RichText(
              text: const TextSpan(
                text: 'UPHF Chatbot',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black), 
              ),
            )
          ],
        ),
      ),
    );
  }
}
