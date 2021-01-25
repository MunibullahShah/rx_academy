import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalizationRepository {
  Map<String, dynamic> localization;
  Map<String, dynamic> customLocalization;

  Map<String, dynamic> arabicLocalization;

  bool isArabic;

  String getLocalization(
    String key,
  ) {

    if (isArabic) if (arabicLocalization.containsKey(key))
      return arabicLocalization[key];

    if (customLocalization.containsKey(key)) return customLocalization[key];
    if (localization.containsKey(key)) return localization[key];
    return "UnknownLetter";
  }

  void saveCustomLocalization(Map<String, dynamic> customLocalization);
}

class LocalizationRepositoryImpl extends LocalizationRepository {
  final String defaultString;
  String customString;
  bool isArabic;

  LocalizationRepositoryImpl(
      this.defaultString, this.arabicString, this.isArabic);

  String arabicString = "";

  @override
  Map<String, dynamic> get arabicLocalization {
    var data = json.decode(arabicString);
    return data;
  }

  @override
  Map<String, dynamic> get localization {
    var data = json.decode(defaultString);
    return data;
  }

  @override
  Map<String, dynamic> get customLocalization {
    if (customString != null) {
      var data = json.decode(customString);
      return data;
    }
    return Map<String, dynamic>();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/custom_localization.json');
  }

  Future<File> writeLocalization(String localeJson) async {
    final file = await _localFile;
    // Write the file.
    return file.writeAsString(localeJson);
  }

  Future<String> readLocalization() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return "";
    }
  }

  @override
  void saveCustomLocalization(Map<String, dynamic> customLocalization) async {
    var jsonString = json.encode(customLocalization);
    await writeLocalization(jsonString);
    customString = jsonString;
  }
}
