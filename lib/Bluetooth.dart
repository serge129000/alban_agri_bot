
/*import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
 class BluePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BluePageState();

}
class BluePageState extends State<BluePage>{
   FlutterBluetoothSerial blue=FlutterBluetoothSerial.instance;
  //
  List<BluetoothDevice> devices=[];

  BluetoothState _bluetoothState=BluetoothState.UNKNOWN;
  bool iscan=false;

  //get blue => null;
  @override
  void initState(){
    super.initState();
    blue.state.then((state) {
      setState(() {
        _bluetoothState=state;
        iscan=true;
      });
    });
    blue.onStateChanged().listen((state) {
      setState(() {
      _bluetoothState=state;
      if(_bluetoothState== BluetoothState.STATE_ON){
        scanDevice();
      }else
        if(_bluetoothState==BluetoothState.STATE_OFF){
          showDialog(context: context,
              builder: (context){
            return AlertDialog(
              title: Text("Bluetooth non active"),
              content: Text("veillez active le bluetooth"),
            );
              });
        }
    });
    });
  }
  scanDevice()async{
    iscan=false;
    List<BluetoothDevice> device=[];
    devices.clear();
    try{
      blue.startDiscovery();
      final device=await blue.startDiscovery();
     for(var device in devices){
       blue.getBondedDevices().then((List<BluetoothDevice> devices) {
         setState(() {
           Device=devices;
           device=Device;
         });
       });
     }

    } catch(e){
      print(e);
    }
  }

  scanStop() async{
    iscan=true;
    blue.cancelDiscovery();
  }

  connection (BluetoothDevice device) async{
    try{
      await blue.connect(device);
    } catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth"),
      ),
      body:
      ListView.builder(
        itemCount: Device.length,
          itemBuilder:(context,index){
          return Card(child: ListTile(
          title: Text(Device[index].name!),
          subtitle: Text(Device[index].address!),
          leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.bluetooth,color:Colors.white),
    ),
    onTap: (){
            setState(() {
              connection( Device[index]);
            });
    },

          ),
    );
    },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            iscan?scanDevice():scanStop();
          });
        },
        child: Icon(iscan?Icons.search:Icons.stop),
      ),
    );
  }
}*/
