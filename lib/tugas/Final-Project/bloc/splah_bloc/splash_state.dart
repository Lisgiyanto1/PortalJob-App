import 'package:flutter/material.dart';

abstract class SplashState {}

class InitialState extends SplashState {}

class LoadingState extends SplashState {}

class LoggedInState extends SplashState {}

class LoggedOutState extends SplashState {}

class NavigationState extends SplashState {
  final BuildContext context;

  NavigationState({required this.context});
}
