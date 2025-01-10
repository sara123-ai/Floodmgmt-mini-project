import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // for timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the login screen after 3 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Full-screen, hiding status and navigation bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color
      body: Stack(
        fit: StackFit.expand, // Ensures the stack takes full screen
        children: [
          // Fullscreen image with BoxFit.cover
          Image.asset(
            'assets/images/logo.png', // Replace with your logo or image path
            fit: BoxFit.cover, // Ensures the image covers the whole screen
          ),

          // Overlaying CircularProgressIndicator and content on top of the image
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Optional loading indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 30),

              // Optional text below the progress indicator
              Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Restore system UI when splash screen is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
