import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/home.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'colorful'),
    home: Home(),
  ));
}