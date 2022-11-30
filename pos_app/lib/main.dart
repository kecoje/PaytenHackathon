import 'package:dateafterpay/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date After Pay',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Date After Pay'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: paddy),
          QrImage(
            data: """
{
	products: [
		{
			title:	"Jack Daniels 0.7",
			count: 1,
		},
		{
			title:	"Jabuka Ajdared",
			count: "1kg",
		},
		{
			title:	"Cigarete Marlboro 100s",
			count: 1,
		},
		{
			title:	"Negro bombone",
			count: 3,
		},
		{
			title:	"Milka Noisette",
			count: 2,
		},
	]
}""",
            version: QrVersions.auto,
            size: 200.0,
          ),
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
