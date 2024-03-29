import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rx_academy/data/cache/cache_manager.dart';
import 'package:rx_academy/data/repository/auth_repository.dart';
import 'package:rx_academy/ui/screen/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    if (options.headers.containsKey("requirestoken")) {
      //remove the auxiliary header
      options.headers.remove("requirestoken");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var header = prefs.get("apiToken");
      options.headers.addAll({"token": "$header"});

      return options;
    }
    return options;
  }

  @override
  Future<dynamic> onError(DioError err) async {
    if (err.response != null &&
        err.response.statusCode != null &&
        err.response.statusCode == 401) {
      (await CacheManager()).cleanCache();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("apiToken", "");
      navigatorKey.currentState.pushNamed(SplashScreen.routeName);
    }
    return err;
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    return response;
  }
}
