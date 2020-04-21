import 'package:annotations/infra/date/format_date.dart';
import 'package:annotations/infra/debounce.dart';
import 'package:annotations/presentation/app_tab_base.dart';
import 'package:annotations/presentation/cancelar_button.dart';
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
  final _debouncer = Debouncer(milliseconds: 500);

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
        color: Colors.orangeAccent[100],
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          padding: const EdgeInsets.only(bottom:10.0),
          child: Column(
            children:[
              Row(
                children:[
              Expanded(child:TextField(style: renderStyleApp(),
                onChanged: (text)=>{ _debouncer.run(() => widget.cardController.updateTemplate(index, text))},
                controller: new TextEditingController(
                text: widget.cardController.templateCards[index].titulo),
                decoration: InputDecoration(
                hintText: "Digite um titulo",
                ),
              )),cancelar(Colors.green,Colors.orangeAccent[100],
                 ()=> widget.cardController.deleteTemplate(index))],),
              Expanded(child:SingleChildScrollView(child:
              TextFieldApp(widget.cardController.templateCards[index].card.text,
            "inicie sua anotação",(text) =>{ _debouncer.run(() => widget.cardController.saveNoteOrUpdateCard(index, text))})))
            ]),
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      body: Observer(builder:(_) => renderAppTabLayouTbuild(context,[
        Container(
          margin: const EdgeInsets.only(bottom: 25.0),
          child: Text(formatData(widget.cardController.date),
            style: renderStyleApp())),
        ListView.builder(
        itemBuilder: (context, index) => _makeCard(context, index),
        itemCount: widget.cardController.templateCards.length,
        scrollDirection: Axis.vertical,
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap:true,
        )])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.cardController.insertTemplate(""); },
        child: Icon(Icons.add),
        backgroundColor: Colors.green, 
      ),
      bottomNavigationBar: BottomAppBar(
        child:TabApp(controller:widget.cardController,iconMode: Icons.view_list),
        shape: const CircularNotchedRectangle()),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
   

  }
}