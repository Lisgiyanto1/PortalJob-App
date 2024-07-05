import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/splash_event.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/splash_state.dart';
import 'package:flutter_app/tugas/Final-Project/loginScreen.dart';
import 'package:flutter_app/tugas/Final-Project/navigation.dart';

abstract class NavigationState {}

class NavigationBloc extends BlocBase {
  NavigationState? _navigationState;

  NavigationBloc(NavigationState? initialState, {required BuildContext context})
      : super(initialState ?? InitialState()) {
    _navigationState = (initialState ?? InitialState()) as NavigationState?;
  }

  void navigateToLoginScreen(BuildContext context) {
    _navigationState = NavigationStateLogin();
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  void autoLogin(BuildContext context) {
    _navigationState = NavigationStateNavigationBar();
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationBarScreen()),
          (route) => false);
    });
  }
}

class NavigationStateInitial extends NavigationState {}

class NavigationStateLogin extends NavigationState {}

class NavigationStateNavigationBar extends NavigationState {}

class NavigationStateChangedEvent extends SplashEvent {
  final NavigationState? navigationState;

  NavigationStateChangedEvent({required this.navigationState});
}
