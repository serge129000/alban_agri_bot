import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BluePage extends StatefulWidget {  @override
  State<StatefulWidget> createState() => BlueState();
}
class BlueState extends State<BluePage> {
 final FlutterBlue blue = FlutterBlue.instance;
 late BluetoothDevice deviceDevice ;
 late BluetoothCharacteristic getCharacteristic;
  List<String> receivedData= [];
  bool isscan=false;
  List<BluetoothDevice> deviceList=[];

  @override
  void initState(){
    super.initState();
    _requertPermission();
  }
  void  _requertPermission() async{
    await Permission.bluetooth.request().isGranted;
    bool isOn =await blue.isOn;
    if(!isOn){
      showDialog(context: context,
          builder: (BuildContext context){
        return AlertDialog(
          title: Text("Bluetooth Desactive"),
          content: Text("Voulez-vous activez le bluetooth?"),
          actions: <Widget>[
            ElevatedButton(
              child:Text("Oui"),
              onPressed:(){
              openAppSettings();
              },
            ),
            ElevatedButton(
              child:Text("NON"),
              onPressed:(){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
          });
    }

  }

  void _startScan () async{
    deviceDevice==[];
    blue.startScan(timeout: Duration(seconds: 5));
    isscan=true;
    blue.scanResults.listen((results) {
      for(ScanResult r in results){
      if (r.device.name.isNotEmpty){
        deviceDevice =r.device;
      }}
    });
  }

  void _stopScan() async{
    blue.stopScan();
    isscan = false;
  }

  void _connectToDevice() async{
    await deviceDevice.connect();
    getCharacteristic==[];
    List<BluetoothService> service =await deviceDevice.discoverServices();
    service.forEach((service) {
      service.characteristics.forEach((caracteristic) {
        getCharacteristic = caracteristic;
      });
    });
    _startListing;
  }
  void _startListing()async{
    getCharacteristic.setNotifyValue(true);
    getCharacteristic.value.listen((value) {
      setState(() {
        receivedData.add(String.fromCharCodes(value));
      });
    });
  }

  void _sendData(String data) async {
    List<int> bytes =utf8.encode(data);
    await getCharacteristic.write(bytes);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth"),
      ),
      body:
      ListView.builder(
        itemCount: deviceList.length,
        itemBuilder:(context,index){
          BluetoothDevice device = deviceList[index];
          return Card(child: ListTile(
            title: Text(deviceDevice.name!),
            subtitle: Text(deviceDevice.id.toString()),
            trailing: ElevatedButton(
              child: Text(deviceDevice== device?"Deconnecte":"Connecte"),
              onPressed: ()async{
                if (deviceDevice==device){
                  await deviceDevice.disconnect();
                  setState(() {
                    deviceDevice== null;
                    getCharacteristic== null;
                  });
                }else{
                  _connectToDevice();
                }
              },
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.bluetooth,color:Colors.white),
            ),
            // setState(() {
             // });
          //  },

          ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            isscan?_startScan():_stopScan();
          });
        },
        child: Icon(isscan?Icons.search:Icons.stop),
      ),
    );
  }
}
