import 'package:agro_bot/Bluetooth.dart';
import 'package:agro_bot/bluetooth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri-Bot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  double MotBot=0.0;
  double MotDes=0.0;
  double MotHerb=0.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Agri-Bot",style: new TextStyle(
          color: Colors.white,
          fontSize: 25.0,
        ),),
        centerTitle: true,
        actions: [
          IconButton(
        icon: Icon(Icons.bluetooth),
        color: Colors.blue,
        onPressed: (){
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>BluetoothPage()));
            });}
            ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //batterie et seerial printl
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          //Direction
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [//gauche
              IconButton( icon: Icon(Icons.keyboard_double_arrow_left),
                color: Colors.white,
                onPressed:(){
                setState(() {
                });},
              ),

              IconButton( icon: Icon(Icons.stop),
                color: Colors.white,
                onPressed:(){
                  setState(() {
                  });},
              ),
              //droite
              IconButton( icon: Icon(Icons.keyboard_double_arrow_right),
                color: Colors.white,
                onPressed:(){
                  setState(() {
                  });},
              ),
            ],
          ),
          //Guidage des moteurs
          Column(
            children: [
              new Text("vitesse du Bot:$MotBot",
              style: new TextStyle(
                fontSize: 15.2,
                color: Colors.white,
              ),
              ),
              Row(
              children: [
                IconButton( icon: Icon(Icons.play_arrow),
                  color: Colors.white,
                  onPressed:(){
                    setState(() {
                    });},
                ),
                Expanded(
                    child: new Slider(value: MotBot,
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: "$MotBot",
                      onChanged: (double d){
                        setState(() {
                          MotBot=d;
                        });
                      },
                    ),
                ),
              ],
              ),
              new Text("vitesse du Coupe-Herbe:$MotHerb",
                style: new TextStyle(
                  fontSize: 15.2,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  IconButton( icon: Icon(Icons.play_arrow),
                    color: Colors.white,
                    onPressed:(){
                      setState(() {
                      });},
                  ),
                  Expanded(
                    child: new Slider(value: MotHerb,
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: "$MotHerb",
                      onChanged: (double d){
                        setState(() {
                          MotHerb=d;
                        });
                      },
                    ),
                  ),
                ],
              ),
              new Text("vitesse du Desherbeuse:$MotDes",
                style: new TextStyle(
                  fontSize: 15.2,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  IconButton( icon: Icon(Icons.play_arrow),
                    color: Colors.white,
                    onPressed:(){
                      setState(() {
                      });},
                  ),
                  Expanded(
                    child: new Slider(value: MotDes,
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: "$MotDes",
                      onChanged: (double d){
                        setState(() {
                          MotDes=d;
                        });
                      },
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),

    );
  }
}
