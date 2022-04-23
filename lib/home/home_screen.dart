import 'package:flutter/material.dart';
import 'package:practica2/favorites/favorite_screen.dart';

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
      RawMaterialButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => favoriteScreen()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => favoriteScreen()));
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
