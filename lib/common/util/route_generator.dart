import 'package:dog_breeds/common/constants/parameters.dart';
import 'package:dog_breeds/home/home_page.dart';
import 'package:dog_breeds/splash/splash_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case Parameters.pageSplash:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const SplashPage();
          },
        );
      case Parameters.pageHome:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const HomePage();
          },
        );
      /*case Parameters.pageSettings:
        return PageRouteBuilder(
          fullscreenDialog: true,
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return const SettingsPage();
          },
        );*/
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: const Center(
                child: Text("404"),
              ),
            );
          },
        );
    }
  }
}

/*

      routes: {
        Parameters.pageSplash: (context) => const SplashPage(),
        Parameters.pageHome: (context) => const HomePage(),
      },
      onUnknownRoute: (settings) {

      },
 */
