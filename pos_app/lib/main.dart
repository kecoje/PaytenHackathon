import 'package:dateafterpay/my_home_page.dart';
import 'package:dateafterpay/page_routing.dart';
import 'package:dateafterpay/qr_screen.dart';
import 'package:dateafterpay/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
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
      // onUnknownRoute: (settings) {
      //   return MyPageRoute(widget: MyHomePage(title: 'Date After Pay'));
      // },
      title: 'Date After Pay',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      home: ScrollConfiguration(
            behavior: MyBehaviour(),
            child: const MyHomePage(title: 'Date After Pay')),
    );
  }
}


