import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {      
  TextEditingController textoEditingController;
  Function function;
  String hintTexto;
  TextFieldApp(String texto,String hintTexto,Function function){
     this.textoEditingController = new TextEditingController(text:texto);
     this.hintTexto = hintTexto;
     this.function = function;
  }

  void onChange(String texto) async {
    await this.function(texto);
    int offset = textoEditingController.selection.base.offset;
    textoEditingController.text = texto;
    textoEditingController.selection = TextSelection.fromPosition(TextPosition(offset:offset));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: renderStyleApp(),
      onChanged:(texto)=> onChange(texto),                      
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(),
        hintText: this.hintTexto,
      ),
      maxLines: null,
      controller:textoEditingController
      );
                            
  }
}

TextStyle renderStyleApp(){
  return TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    );
}
