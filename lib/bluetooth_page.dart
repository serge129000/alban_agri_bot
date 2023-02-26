import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  List<BluetoothDiscoveryResult> allBluetoothR = [];
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  Map<String, BluetoothDevice> devicesConnected = {};
  bool isLoading = true;
  getAndCheckBluetoothPermission() async{
    if(!await Permission.bluetooth.isGranted){
      await Permission.bluetooth.request();
    }
  }

 Future scanFOrDevice() async{
    await FlutterBluetoothSerial.instance.cancelDiscovery().then((value) => FlutterBluetoothSerial.instance.startDiscovery().listen((event) {
      if(!devicesConnected.containsValue(event.device)) {
        Future.delayed(const Duration(seconds: 5), ()=> setState(() {
          isLoading = false;
          devicesConnected.addAll({
            "device": event.device
          });
        }));
        //connectingToDevice(deviceTobePaired: event.device);
      }
      /*if(devicesConnected.isNotEmpty){
        connectingToDevice(deviceTobePaired: event.device);
      }*/
    }));
  }
  connectingToDevice({required BluetoothDevice deviceTobePaired}) async{
    try{
      BluetoothConnection bluetoothConnection = await BluetoothConnection.toAddress(deviceTobePaired.address);
      if(bluetoothConnection.isConnected){
        print("est connecte");
      } else{
        print("erreur");
      }
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    getAndCheckBluetoothPermission();
    scanFOrDevice();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: List.from(devicesConnected.entries).isNotEmpty? Column(
            children: [
              ...List.from(devicesConnected.entries).map((e) => ListTile(
                leading: Icon(Icons.phone),
                title: Text(e.value.name),
              ))
          ]
          ): Center(
            child: Icon(Icons.history, size: 50,),
          ),
        ),
      ) /*StreamBuilder(
        stream: FlutterBluetooth,Serial.instance.startDiscovery(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError){
            print(snapshot.error);
          }
          return Container();
      },),*/
    );
  }
}
