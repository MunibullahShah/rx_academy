import 'dart:ui';

import 'package:inject/inject.dart';
import 'package:rx_academy/data/models/AppSettings.dart';
import 'package:rx_academy/data/models/category.dart';
import 'package:rx_academy/data/network/api_provider.dart';
import 'package:rx_academy/main.dart';
import 'package:rx_academy/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRepository {
  Future<List<Category>> getCategories();

  Future<AppSettings> getAppSettings();
}

@provide
@singleton
class HomeRepositoryImpl implements HomeRepository {
  final UserApiProvider apiProvider;
  final SharedPreferences _sharedPreferences;

  HomeRepositoryImpl(this.apiProvider, this._sharedPreferences);

  @override
  Future<List<Category>> getCategories() {
    return apiProvider.getCategories();
  }

  @override
  Future<AppSettings> getAppSettings() async {
    AppSettings appSettings = await apiProvider.getAppSettings();

    if (appSettings.options.main_color != null) {
      _sharedPreferences.setInt(
          'main_color_r', appSettings.options.main_color.r);
      _sharedPreferences.setInt(
          'main_color_g', appSettings.options.main_color.g);
      _sharedPreferences.setInt(
          'main_color_b', appSettings.options.main_color.b);
      _sharedPreferences.setDouble(
          'main_color_a', appSettings.options.main_color.a.toDouble());
    }

    if (appSettings.options.secondary_color != null) {
      _sharedPreferences.setInt(
          'second_color_r', appSettings.options.secondary_color.r);
      _sharedPreferences.setInt(
          'second_color_g', appSettings.options.secondary_color.g);
      _sharedPreferences.setInt(
          'second_color_b', appSettings.options.secondary_color.b);
      _sharedPreferences.setDouble(
          'second_color_a', appSettings.options.secondary_color.a.toDouble());
    }
    _sharedPreferences.setBool('app_view', appSettings.options.app_view);

    return appSettings;
  }
}
