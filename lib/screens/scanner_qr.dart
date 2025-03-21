import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/models/qr_assistance.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ScannerQR extends StatefulWidget {
  const ScannerQR({Key? key}) : super(key: key);

  @override
  State<ScannerQR> createState() => _ScannerQR();
}

class _ScannerQR extends State<ScannerQR> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  VehicleService vs = VehicleService();
  FoodService fs = FoodService();
  AssistanceService as = AssistanceService();
  bool isProccesing = false;
  final storage = FlutterSecureStorage();

 
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Accede a los datos usando la clave
  final String data = args?['dataKey'] ?? 'Sin datos';
  
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Text('Flash: ${snapshot.data ==true?'Prendido':'Apagado'}',style: getTextStyleButtonField(context),);
                            },
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.pauseCamera();
                        },
                        child: Text('Pausar',
                            style: getTextStyleButtonField(context)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.resumeCamera();
                        },
                        child: Text('Continuar',
                          style: getTextStyleButtonField(context)),
                      ),
                    ),
                    
                  ],
                ),
                SizedBox(child: Navbar(contexto2: data))
              ],
            ),
          )
        ],
      ),
    );
  }
  

  Widget _buildQrView(BuildContext context) {

    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 250.0
    //     : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? .6
                                      : .3)),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }


  Future<void> _onQRViewCreated(QRViewController controller) async {

    Color color = Colors.red;
    String text = '';
    if (isProccesing == false) {
      setState(() {
        isProccesing = true;
        this.controller = controller;
      });

    VarProvider vp = VarProvider();
    final json = await vp.arrSharedPreferences();

    if (json['turn'] != null) {
      controller.scannedDataStream.listen((scanData) async {
      setState(() {
        isProccesing = true;
        this.controller = controller;
      });
        result = scanData;
        controller.stopCamera();
        Qr newQr = Qr();
        Map<String, dynamic> objetoJson = { 
           for (var e in result!.code.toString().split(',').map((e) => e.trim())) 
           e.split(':')[0].trim() : e.split(':')[1].trim() 
        }; 
        Map<String, dynamic> json = await vp.arrSharedPreferences();

        /**
         * Solo es necesario estos datos para escanear los demas, se insertan manualmente en la base de datos los demas datos
         * tambien puse como opcion, la opcion de actualizar los campos, cuando se escanea el codigo QR, pero lo desahbilite en el PHP igualmente
         */
        
        newQr.fkTurn = json['idTurn'];
        //newQr.color = objetoJson['color'];
        //newQr.departament = objetoJson['departament'];
        //newQr.employeeName = objetoJson['employeeName'];
        //newQr.typevh = objetoJson['typevh'];
        //newQr.platesSearch = objetoJson['plates'];

        newQr.employee_num = objetoJson['numEmployee'];
        newQr.local = int.parse(objetoJson['local']);
    
        if(isProccesing == true){
          if (isNumeric(objetoJson['numEmployee']) && isNumeric(objetoJson['local'])) {
            await vs.postQrVehicle(newQr,context).then((value) {
            if(value.status == 200){
              setState(() {
                color = Colors.green;
                text = 'Scanner completado.';
              });
            }else{
              setState(() {
                color = Colors.red;
                text = 'Error: ${value.container![0]["error"]}';
              });
            }
            });
          }else{
            setState(() {
              color = Colors.red;
              text = 'Error: QR incorrecto';
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: color,
            content: Text(text,style: const TextStyle(color: Colors.white)),
          ));
          await Future.delayed(const Duration(seconds: 5));
        }

        setState(() {
          isProccesing = false;
          this.controller = controller;
          controller.resumeCamera();
        });

      });
    }else if(json["dish"] != null){
      controller.scannedDataStream.listen((scanData) async {
      setState(() {
        isProccesing = true;
        this.controller = controller;
      });
        result = scanData;
        controller.stopCamera();
        QrFood newQr = QrFood();
        Map<String, dynamic> objetoJson = { 
          for (var e in result!.code.toString().split(',').map((e) => e.trim())) 
          e.split(':')[0].trim() : e.split(':')[1].trim() 
        }; 
        // var jsonResult = json.decode(result!.code!);
        // Map<String, dynamic> json = await vp.arrSharedPreferences();

        /**Explicare la logica de aqui, en este caso ya se podra diferenciar entre una persona
         * que es empleado y otra persona que no lo es.
         * El empleado no necesita poner el nombre propio,mientras que alguien que no es empleado, si,
         * la razon por la cual no se puso como acceso manual, es por la razon de que la persona pueda manipular
         * y comer más de 2 veces.
         */
        newQr.numEmployee = objetoJson['numEmployee'];
        newQr.contract = objetoJson['contract'];
        newQr.name = objetoJson['employeeName'] ?? '';
        newQr.local = objetoJson['local'];
        newQr.localApp = await storage.read(key: 'idHotelRegister');
        if(isProccesing == true){
            if (isNumeric(objetoJson['numEmployee']) && isNumeric(objetoJson['contract']) && isNumeric(objetoJson['local'])) {
             await fs.postQrFood(newQr,context).then((value) {
              if(value.status == 200){
                setState(() {
                  color = Colors.green;
                  text = 'Scanner completado.';
                });
              }else{
                setState(() {
                  color = Colors.red;
                  text = 'Error: ${value.container![0]["error"]}';
                });
              }
            }); 
            }else{
              setState(() {
                  color = Colors.red;
                  text = 'Error: QR incorrecto';
                });
            }
            
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: color,
            content: Text(text,style: const TextStyle(color: Colors.white)),
          ));
          await Future.delayed(const Duration(seconds: 5));
        }

        setState(() {
          isProccesing = false;
          this.controller = controller;
          controller.resumeCamera();
        });

      });
    }else{
      controller.scannedDataStream.listen((scanData) async {
      setState(() {
        isProccesing = true;
        this.controller = controller;
      });
        result = scanData;
        controller.stopCamera();
        QrAssistance newQr = QrAssistance();
        Map<String, dynamic> objetoJson = { 
           for (var e in result!.code.toString().split(',').map((e) => e.trim())) 
           e.split(':')[0].trim() : e.split(':')[1].trim() 
        }; 
        // var jsonResult = json.decode(result!.code!);
        // Map<String, dynamic> json = await vp.arrSharedPreferences();
        newQr.employee_num = objetoJson['numEmployee'];
        newQr.idTurn = json['idTurn'];
        newQr.local = objetoJson['local'];
        if(isProccesing == true){
          if (isNumeric(objetoJson['numEmployee'] ) 
          && isNumeric(objetoJson['local'] )) {
            await as.postQrAssistance(newQr,context).then((value) {
            if(value.status == 200){
              setState(() {
                color = Colors.green;
                text = 'Scanner completado.';
              });
            }else{
              setState(() {
                color = Colors.red;
                text = 'Error: ${value.container![0]["error"]}';
              });
            }
          });
          }else{
            setState(() {
              color = Colors.red;
              text = 'Error: QR incorrecto';
            });
          }
            
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: color,
            content: Text(text,style: const TextStyle(color: Colors.white)),
          ));
          await Future.delayed(const Duration(seconds: 5));
        }

        setState(() {
          isProccesing = false;
          this.controller = controller;
          controller.resumeCamera();
        });

      });
    }
     
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      // Si los permisos se deniegan, establecer isProccesing en false
      setState(() {
        isProccesing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se otorgaron los permisos')),
      );
    }
  }
  
  bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
