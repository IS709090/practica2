import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_logic_bloc.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Sign In", style: TextStyle(fontSize: 40)),
          backgroundColor: Colors.black),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/soundWaveGif.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            Image.asset(
              'assets/images/soundWave.png',
              height: 200,
              width: 200,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .3),
            MaterialButton(
                height: MediaQuery.of(context).size.height * .03,
                hoverColor: Color.fromARGB(255, 17, 61, 18),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.g_mobiledata_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      "Iniciar Sesión con Google",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                color: Colors.green,
                minWidth: MediaQuery.of(context).size.width - 30,
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                }),
          ]),
        ),
      ),
    );
  }
}
