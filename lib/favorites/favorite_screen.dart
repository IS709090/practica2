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
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => favoriteScreen()));
                    },
                    elevation: 3.33,
                    child: Icon(Icons.favorite, color: Colors.white),
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
