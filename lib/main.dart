import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/home/home_screen.dart';

import 'authentication/bloc/auth_logic_bloc.dart';
import 'authentication/login_screen.dart';
import 'home/bloc/recording_bloc.dart';

// void main() => runApp(FindTrackApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => RecordingBloc(),
        ),
      ],
      child: FindTrackApp(),
    ),
  );
}

class FindTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindTrackApp',
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Usuario no autenticado"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            print(">> Estas loggeado!");
            return homeScreen();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return loginScreen();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
