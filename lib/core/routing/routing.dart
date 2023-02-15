import 'package:flutter/material.dart';
import 'package:map_project/core/utils/app_strings.dart';
import 'package:map_project/features/authentication/screens/login_screen.dart';
import 'package:map_project/features/authentication/screens/otp_screen.dart';
import 'package:map_project/features/map/screen/map_screen.dart';
import 'package:map_project/features/splash/screen/splash_screen.dart';


class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppStrings.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppStrings.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen(),);
        case AppStrings.otpRoute:
        return MaterialPageRoute(builder: (_) => OtpScreen(),settings: settings);
      case AppStrings.mapRoute:
        return MaterialPageRoute(builder: (_) => const MapScreen(),);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }


}