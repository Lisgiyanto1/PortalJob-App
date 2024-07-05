import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/explore_bloc/job_explore_bloc.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/splah_bloc/navigation_bloc.dart';
import 'package:flutter_app/tugas/Final-Project/services/explore-repositories/explore_repositories.dart';

import 'package:flutter_app/tugas/Final-Project/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the binding
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) =>
              NavigationBloc(NavigationStateInitial(), context: context),
          lazy: false, // Pastikan bloc langsung dibuat
        ),
        BlocProvider<JobExploreBloc>(
          create: (context) => JobExploreBloc(jobRepository: JobService()),
          lazy: false, // Pastikan bloc langsung dibuat
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: BlocBuilder<JobExploreBloc, JobExploreState>(
        builder: (context, state) {
          return Scaffold(
            body: SplashScreen(), // Wrap SplashScreen here
          );
        },
      ),
    );
  }
}
