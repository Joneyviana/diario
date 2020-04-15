import 'package:flutter/material.dart';

cancelar(Color backgroundColor,Color textColor,Function function){
  return MaterialButton(
  onPressed:function,
  color:backgroundColor,
  textColor: textColor ,
  child: Icon(
    Icons.cancel,
    size: 24,
  ),
  padding: EdgeInsets.all(16),
  shape: CircleBorder(),
);
}