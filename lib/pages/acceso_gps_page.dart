

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class AccesoGpsPage extends StatefulWidget {

  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage> with WidgetsBindingObserver{

  @override
  void initState() { 
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    
  }

  @override
  void dispose() { 
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    print (state);
    if (state == AppLifecycleState.resumed){
      if  (await Permission.location.isGranted){
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario activar el GPS'),
            MaterialButton(
              child: Text('Solicitar Acceso', style:TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                final status = await Permission.location.request();
                await this.accesoGPS(status);
                  //TODO: VERIFICAR GPS
              })
          ],
        ),
     ),
   );
  }

  Future accesoGPS(PermissionStatus status)async{
    switch (status) {
  
      case PermissionStatus.limited:
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.undetermined:
        openAppSettings();

    }

  }
}