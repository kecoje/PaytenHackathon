import 'package:dateafterpay/qr_screen.dart';
import 'package:dateafterpay/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyBehaviour extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date After Pay',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: MyBehaviour(),
            child: const MyHomePage(title: 'Date After Pay'));
      },
      // home: const MyHomePage(title: 'Date After Pay'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? scannedUserId;
  bool qrOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: qrOpen
          ? QRScanner(getScanned: (String scanned) {
              setState(() {
                scannedUserId = scanned;
                qrOpen = false;
              });
            })
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: paddy),
                scannedUserId == null
                    ? InkWell(
                        radius: 1001,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(1001)),
                        splashColor: Colors.white38,
                        onTap: () {
                          setState(() {
                            qrOpen = true;
                          });
                          // print("HEHEHEHE");
                          // showModalBottomSheet(
                          //     context: context,
                          //     isScrollControlled: false,
                          //     backgroundColor: Colors.transparent,
                          //     builder: (ctx) {
                          //       return Container(
                          //         padding: EdgeInsets.only(
                          //             bottom:
                          //                 MediaQuery.of(ctx).viewInsets.bottom),
                          //         child: QRScanner(getScanned: (String scanned) {
                          //           setState(() {
                          //             scannedUserId = scanned;
                          //           });
                          //         }),
                          //       );
                          //     });
                        },
                        child: Ink(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(1001)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 5,
                                    blurRadius: 10)
                              ]),
                          child: Container(
                            child: Center(
                              child: Text(
                                "SCAN QR",
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Text(scannedUserId!),
                          SizedBox(height: paddy),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(1001)),
                                ),
                            child: Container(
                              child: Center(child: Icon(Icons.check)),
                            ),
                          ),
                          SizedBox(height: paddy),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                scannedUserId = null;
                              });
                            },
                            child: Text("U REDU"),
                          )
                        ],
                      ),
                SizedBox(height: paddy),
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(paddy),
                      children: [
                        _builtProductTile("1x Jack Daniels 0.7", 2500),
                        _builtProductTile("1kg Jabuka Ajdared", 120),
                        _builtProductTile("1x Cigarete Marlboro 100s", 470),
                        _builtProductTile("3x Negro bombone", 360),
                        _builtProductTile("2x Milka Noisette", 500),
                      ]),
                )
                // Container(
                //   width: 50,
                //   height: 50,
                //   color: Colors.red,
                // )
              ],
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Container _builtProductTile(String name, int price) {
    var formatter = NumberFormat('#,###');

    return Container(
      margin: EdgeInsets.only(bottom: paddy),
      padding: EdgeInsets.all(paddy),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(11)),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Text(name),
          Spacer(),
          Text("${formatter.format(price)}.00"),
        ],
      ),
    );
  }
}
