import 'package:flutter/material.dart';
import 'package:practica2/home/home_screen.dart';

class favoriteScreen extends StatefulWidget {
  favoriteScreen({Key? key}) : super(key: key);

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
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.4,
        child: GestureDetector(
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
                    onPressed: () {},
                    child: const Text('Continuar'),
                  ),
                ],
              ),
            );
          },
          child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/soundWaveGif.gif"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 3.33,
                        child:
                            Icon(Icons.favorite, color: Colors.red, size: 30),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.maxFinite,
                      color: Colors.blue,
                      child: Text(
                        "Titulo de la canción" + "\n" + "Artista de la canción",
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
        ),
      )),
    );
  }
}
