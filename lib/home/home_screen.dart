import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/favorites/favorite_screen.dart';
import 'package:practica2/foundSong/foundScreen.dart';
import 'package:practica2/home/bloc/recording_bloc.dart';

import '../authentication/bloc/auth_logic_bloc.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(height: 70),
      Text(
        "Toque para escuchar",
        style: const TextStyle(fontSize: 20),
      ),
      Container(
        height: 100,
      ),
      BlocConsumer<RecordingBloc, RecordingState>(builder: (context, state) {
        return Container();
      }, listener: (context, state) {
        if (state is RecordingFound) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => foundScreen(
                      album: state.album,
                      spotifyLink: state.spotifyLink,
                      appleMusicLink: state.appleMusicLink,
                      artist: state.artist,
                      image: state.image,
                      date: state.date,
                      listnLink: state.listnLink,
                      name: state.name)));
        }
      }),
      RawMaterialButton(
        onPressed: () {
          BlocProvider.of<RecordingBloc>(context).add(RecordingOnSearch());
        },
        elevation: 3.33,
        fillColor: Colors.white,
        child: Image.asset(
          'assets/images/soundWave.png',
          height: 200,
          width: 200,
        ),
        shape: CircleBorder(),
      ),
      SizedBox(height: 100),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => favoriteScreen()));
            },
            elevation: 3.33,
            fillColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.black),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Cerrar sesión'),
                  content: const Text(
                      'Al cerrar sesión de su cuenta será redirigido a la pantalla de Log In, ¿Quiere continuar?',
                      textAlign: TextAlign.justify),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cerrar sesión');
                        BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                      },
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              );
            },
            elevation: 3.33,
            fillColor: Colors.white,
            child: Icon(Icons.logout, color: Colors.black),
            shape: CircleBorder(),
          ),
        ],
      )
    ])));
  }
}
