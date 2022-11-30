import 'package:flutter/material.dart'; 
  
 class MyPageRoute extends PageRouteBuilder { 
   MyPageRoute( 
       {required this.widget, 
       this.beginOffset = const Offset(1.0, 0.0), 
       this.instant = false}) 
       : super( 
             transitionDuration: Duration(milliseconds: instant ? 0 : 400), 
             reverseTransitionDuration: 
                 Duration(milliseconds: instant ? 0 : 300), 
             transitionsBuilder: (BuildContext context, 
                 Animation<double> animation, 
                 Animation<double> secAnimation, 
                 Widget child) { 
               var begin = beginOffset; 
               var end = Offset.zero; 
               var curve = Curves.ease; 
  
               var tween = 
                   Tween(begin: begin, end: end).chain(CurveTween(curve: curve)); 
  
               return SlideTransition( 
                 position: animation.drive(tween), 
                 child: child, 
               ); 
             }, 
             pageBuilder: (BuildContext context, Animation<double> animation, 
                 Animation<double> secAnimation) { 
               return widget; 
             }); 
  
   final Widget widget; 
   final Offset beginOffset; 
   final bool instant; 
 }