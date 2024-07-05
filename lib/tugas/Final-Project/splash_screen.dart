import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/navigation_bloc.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/splash_bloc.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/splash_event.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/splash_state.dart';
import 'package:flutter_app/tugas/Final-Project/loginScreen.dart';

import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:flutter_app/tugas/Final-Project/services/user-repositorie/users_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late SplashBloc _splashBloc;
  late NavigationBloc navigationBloc;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animationController.repeat(reverse: true);

    navigationBloc = NavigationBloc(NavigationStateInitial(), context: context);
    _splashBloc = SplashBloc(
        userRepository: UserRepository(),
        navigationBloc: navigationBloc,
        context: context);
    _splashBloc.add(AutoLoginEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryColor,
      body: BlocBuilder<SplashBloc, SplashState>(
        bloc: _splashBloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoggedInState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animationController.value * 0.5 + 1.0,
                          child: child,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/img/logo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'You\'re logged in!',
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 245, 250, 245),
                        ),
                        speed: Duration(milliseconds: 30),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is LoggedOutState) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animationController.value * 0.5 + 1.0,
                          child: child,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/img/logo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'You\'re not logged in!',
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 6, 6, 6),
                        ),
                        speed: Duration(milliseconds: 30),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _splashBloc.close();
    navigationBloc.close();
    super.dispose();
  }
}
