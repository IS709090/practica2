import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:practica2/home/home_screen.dart';
import 'package:practica2/favorites/songClass.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/bloc/recording_bloc.dart';

class favoriteScreen extends StatefulWidget {
  final CollectionReference<Song> query;

  favoriteScreen({required this.query});

  @override
  List<Object> get props => [this.query];

  @override
  State<favoriteScreen> createState() => _favoriteScreenState();
}

class _favoriteScreenState extends State<favoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homeScreen()));
              },
              icon: const Icon(Icons.arrow_back))),
      body: FirestoreListView<Song>(
        query: widget.query,
        itemBuilder: (context, snapshot) {
          Song song = snapshot.data();
          print("Hola222!");
          print(song);

          return GestureDetector(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Abrir Canción'),
                  content: const Text(
                      'Será redirigido a ver opciones para abrir la canción, ¿Quieres continuar?',
                      textAlign: TextAlign.justify),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, 'Continuar');
                        await launch(song.listnLink);
                      },
                      child: const Text('Continuar'),
                    ),
                  ],
                ),
              );
            },
            child: Stack(
              children: [
                Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(song.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Spacer(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: double.maxFinite,
                            color: Colors.blue,
                            child: Text(
                              song.name + "\n" + song.artist,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 23,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: RawMaterialButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Eliminar Canción'),
                          content: const Text(
                              'Esta acción eliminará la canción de su lista de favoritos ¿Quieres continuar?',
                              textAlign: TextAlign.justify),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Cancelar'),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Continuar');
                                BlocProvider.of<RecordingBloc>(context).add(
                                    RecordingRemoveFavorite(id: snapshot.id));
                              },
                              child: const Text('Continuar'),
                            ),
                          ],
                        ),
                      );
                    },
                    elevation: 3.33,
                    child: Icon(Icons.favorite, color: Colors.red, size: 30),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
