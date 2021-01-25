import 'package:flutter/foundation.dart';

class LanguageBloc extends ChangeNotifier
{
  String _language;

  LanguageBloc(this._language);

  String get language => _language;

  set language(String value) {
    _language = value;
    notifyListeners();

  }
}