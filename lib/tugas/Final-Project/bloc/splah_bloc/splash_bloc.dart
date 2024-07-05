import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/navigation_bloc.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/splash_event.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/splash_state.dart';

import 'package:flutter_app/tugas/Final-Project/services/user-repositorie/users_repositories.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository _userRepository;
  final NavigationBloc _navigationBloc;

  SplashBloc(
      {required UserRepository userRepository,
      required NavigationBloc navigationBloc,
      required BuildContext context})
      : _userRepository = userRepository,
        _navigationBloc = navigationBloc,
        super(InitialState()) {
    on<AutoLoginEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final isAuthenticated = await _userRepository.isAuthenticated();
        if (isAuthenticated) {
          emit(LoggedInState());
          _navigationBloc.autoLogin(context);
        } else {
          emit(LoggedOutState());
          _navigationBloc.navigateToLoginScreen(context);
        }
      } catch (e) {
        emit(LoggedOutState());
        _navigationBloc.navigateToLoginScreen(context);
      }
    });

    on<NavigationStateChangedEvent>((event, emit) {
      if (event.navigationState is NavigationStateLogin) {
        emit(LoggedOutState());
      } else if (event.navigationState is NavigationStateNavigationBar) {
        emit(LoggedInState());
      }
    });
  }
}
