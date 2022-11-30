import 'dart:io';

import 'package:dateafterpay/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  QRScanner({super.key, required this.getScanned});

  void Function(String) getScanned;

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey();
  // Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
        // backgroundColor: lightBackground,
        // body: QRView(
        //   key: qrKey,
        //   onQRViewCreated: _onQRViewCreated,
        // ),
        Stack(
      fit: StackFit.expand,
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(paddy)),
                  )),
            ))
      ],
    );
    // Expanded(
    //   flex: 1,
    //   child: Center(
    //     child: (result != null)
    //         ? Text(
    //             'Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}')
    //         : const Text('Scan a code'),
    //   ),
    // )
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    setState(() {
      controller.resumeCamera(); // FIX
    });
    controller.scannedDataStream.listen((scanData) {
      // setState(() {
      //   result = scanData;
      // });
      widget.getScanned(scanData.code ?? '');
      setState(() {
        controller.pauseCamera(); // FIX
      });
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
