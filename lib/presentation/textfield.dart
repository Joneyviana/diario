import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {      
  String texto;
  Function function;
  String hintTexto;
  TextFieldApp(this.texto,this.hintTexto,this.function);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: renderStyleApp() ,
      onChanged: this.function,                      
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(),
        hintText: this.hintTexto,
      ),
      maxLines: null,
      controller: new TextEditingController(
        text: this.texto),
      );
                            
  }
}

TextStyle renderStyleApp(){
  return TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    );
}
