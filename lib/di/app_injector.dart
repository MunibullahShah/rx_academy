import 'package:inject/inject.dart';
import 'package:rx_academy/di/modules.dart';
import 'package:rx_academy/ui/screen/auth/auth_screen.dart';
import 'package:rx_academy/ui/screen/home/home_screen.dart';
import 'package:rx_academy/ui/screen/splash/splash_screen.dart';

import '../main.dart';
import 'app_injector.inject.dart' as g;

@Injector(const [AppModule])
abstract class AppInjector {
  @provide
  MyApp get app;

  @provide
  AuthScreen get authScreen;

  @provide
  HomeScreen get homeScreen;

  @provide
  SplashScreen get splashScreen;

  static Future<AppInjector> create() {
    return g.AppInjector$Injector.create(AppModule());
  }
}
