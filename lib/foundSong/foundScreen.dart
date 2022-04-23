import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class foundScreen extends StatefulWidget {
  foundScreen({Key? key}) : super(key: key);

  @override
  State<foundScreen> createState() => _foundScreenState();
}

class _foundScreenState extends State<foundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Here you go"),
          actions: [
            RawMaterialButton(
              onPressed: () {},
              elevation: 3.33,
              child: Icon(Icons.favorite, color: Colors.white),
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homeScreen()));
              },
              icon: const Icon(Icons.arrow_back))),
      body: Center(
          child: Column(
        children: [
          Image.asset(
            'assets/images/soundWaveGif.gif',
            fit: BoxFit.contain,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Center(
              child: Text(
                'Titulo de la canción' +
                    "\n" +
                    "Albúm de la cancion" +
                    "\n" +
                    "Artista de la canción" +
                    "\n" +
                    "Fecha de la cancion",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Abrir con",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    iconSize: 50,
                    onPressed: () {},
                    icon: Image.asset("assets/images/spotifyIcon.png")),
                IconButton(
                    iconSize: 50,
                    onPressed: () {},
                    icon: Icon(Icons.music_note)),
                IconButton(
                    iconSize: 50,
                    onPressed: () {},
                    icon: Image.asset("assets/images/appleIcon.png")),
              ],
            ),
          )
        ],
      )),
    );
  }
}
