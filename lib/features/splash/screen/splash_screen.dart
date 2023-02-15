import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_project/core/utils/app_constants.dart';
import 'package:map_project/core/utils/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(
      const Duration(
        seconds: AppConstants.splashDelay,
      ),
      _goNext,
    );
  }

  _goNext() {
     late String nextRoute;
     if ( FirebaseAuth.instance.currentUser?.uid != null) {
       nextRoute=AppStrings.mapRoute;
     } else {
nextRoute=AppStrings.loginRoute;
     }


    Navigator.pushReplacementNamed(
      context,
     nextRoute,
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash.jpg',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
