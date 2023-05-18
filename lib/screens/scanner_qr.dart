import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';

class ScannerQR extends StatefulWidget {
  const ScannerQR({Key? key}) : super(key: key);

  @override
  State<ScannerQR> createState() => _ScannerQR();
}

class _ScannerQR extends State<ScannerQR> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  DepartamentService ds = DepartamentService();
  VarProvider vp = VarProvider();
 
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
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  
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
                              return Text('Flash: ${snapshot.data ==true?'Prendido':'Apagado'}');
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
                        child: const Text('Pausar',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.resumeCamera();
                        },
                        child: const Text('Continuar',
                          style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(child: Navbar(contexto2: 'scanner_qr'))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
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

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
    setState(() async {
        result = scanData;
        Qr newQr = Qr();
        Map<String, dynamic> objetoJson = { 
          for (var e in result!.code.toString().split(',').map((e) => e.trim())) 
          e.split(':')[0].trim() : e.split(':')[1].trim() 
        };
        
        Map<String, dynamic> json = await vp.arrSharedPreferences();

        print(json['name']);
        newQr.color = objetoJson['color'];
        newQr.department = objetoJson['departament'];
        newQr.employeeName = objetoJson['employeeName '];
        // newQr.fkTurn = ;
        newQr.typevh = objetoJson['typeVh'];
        newQr.plates = objetoJson['plates'];
        ds.postQr(newQr);


      /*showDialog(
      context: context,
      builder: (BuildContext context) {
        Qr newQr = Qr();
        DepartamentService ds = DepartamentService();
        newQr.color = objetoJson['color'];
        newQr.department = objetoJson['departament'];
        newQr.employeeName = objetoJson['employeeName '];
        newQr.fkTurn = 1;
        newQr.typevh = objetoJson['typeVh'];
        newQr.plates = objetoJson['plates'];
        ds.postQr(newQr);
        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: const Text('LEYENDO QR'),
              content: Container(
                child: Text('JSONCOMPLETO: ${json}, RECUPERANDO DATO EN JSON ${objetoJson['calle']}'),
              )
             )
              ]
              );
            
          }
        );*/
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          content: Text('Scanner completado'),
        ),
      );

      controller.stopCamera();
      await Future.delayed(const Duration(seconds: 5));
      controller.resumeCamera();

      });
      
      

      
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
