import 'package:flutter/material.dart';

abstract class SplashEvent {}

class AutoLoginEvent extends SplashEvent {
  final BuildContext context;

  AutoLoginEvent({required this.context});
}
