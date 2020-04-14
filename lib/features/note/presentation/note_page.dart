import 'package:flutter/material.dart';
import 'package:annotations/infra/date/format_date.dart';
import 'package:annotations/infra/debounce.dart';
import 'package:annotations/presentation/app_tab_base.dart';
import 'package:annotations/presentation/tab.dart';
import 'package:annotations/presentation/textfield.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'note_controller.dart';

class NotePage extends StatefulWidget {
  NoteController noteController;
  NotePage({Key key,this.noteController}) : super(key: key){

  }

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> with WidgetsBindingObserver {

  final _debouncer = Debouncer(milliseconds: 500);

  DateTime newDateTime;

  @override
  void initState() {
    widget.noteController.initNote();
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
  if(state == AppLifecycleState.paused){
    print("pausou essa bosta");
    widget.noteController.updateNote();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Observer(builder:(_) => renderAppTabLayouTbuild(context,[
        Container(
          margin: const EdgeInsets.only(bottom: 25.0),
          child: Text(formatData(widget.noteController.date),
            style: renderStyleApp())),
          TextFieldApp(widget.noteController.texto,"Inicie sua anotação",
           (text) {_debouncer.run(() => widget.noteController.saveNoteOrUpdate(text));})
                  ],TabApp(controller:widget.noteController,iconMode:Icons.view_column))));
  }
}

