import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:rx_academy/data/models/AppSettings.dart';
import 'package:rx_academy/data/network/api_provider.dart';
import 'package:rx_academy/data/repository/auth_repository.dart';
import 'package:rx_academy/data/repository/home_repository.dart';
import 'package:rx_academy/main.dart';

import './bloc.dart';

@provide
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _repository;
  final HomeRepository _homeRepository;
  final UserApiProvider _apiProvider;

  SplashBloc(this._repository, this._homeRepository, this._apiProvider);

  @override
  SplashState get initialState => InitialSplashState();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is CheckAuthSplashEvent) {
      bool signed = await _repository.isSigned();
      yield InitialSplashState();
      try {
        AppSettings appSettings = await _homeRepository.getAppSettings();
        try {
          // var locale = await _apiProvider.getLocalization();
          //
          // localizations.saveCustomLocalization(locale);
        } catch (e) {}

        yield CloseSplash(signed, appSettings);
      } catch (e, s) {
        yield CloseSplash(signed, null);

        print(e);
        print(s);
        //yield ErrorSplashState();
      }
    }
  }
}
