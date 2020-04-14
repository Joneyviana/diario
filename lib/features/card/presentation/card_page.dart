import 'package:annotations/infra/date/format_date.dart';
import 'package:annotations/presentation/app_tab_base.dart';
import 'package:annotations/presentation/tab.dart';
import 'package:annotations/presentation/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'card_controller.dart';

class CardPage extends StatefulWidget  {
  CardController cardController;
  CardPage({Key key,this.cardController}) : super(key: key);

  @override
  _CardNoteState createState() => _CardNoteState();
}

class _CardNoteState extends State<CardPage> with WidgetsBindingObserver {
  @override
  void initState() {
    widget.cardController.initTemplate();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if(state == AppLifecycleState.resumed){
    //widget.cardController.updateNote();
  }
}


  Container _makeCard(BuildContext context,int index){
    return Container( 
      height: 200,
      child:Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .0)),
          child: Column(
            children:[
              TextField(style: renderStyleApp(),
                onChanged: (text)=> widget.cardController.updateTemplate(index, text),
                controller: new TextEditingController(
                text: widget.cardController.titulos[index]),
                decoration: InputDecoration(
                hintText: "Digite um titulo",
                ),
              ),
              TextFieldApp(widget.cardController.textos[index],
            "inicie sua anotação",(text) => widget.cardController.saveNoteOrUpdateCard(index, text))
            ]),
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder:(_) => renderAppTabLayouTbuild(context,[
        Container(
          margin: const EdgeInsets.only(bottom: 25.0),
          child: Text(formatData(widget.cardController.date),
            style: renderStyleApp())),
        ListView.builder(
        itemBuilder: (context, index) => _makeCard(context, index),
        itemCount: widget.cardController.templateCards.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true
        )],TabApp(controller:widget.cardController,iconMode: Icons.view_list,))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.cardController.insertTemplate(""); },
        child: Icon(Icons.add),
        backgroundColor: Colors.green, 
      )
    );
   

  }
}