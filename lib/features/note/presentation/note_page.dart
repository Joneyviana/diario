import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:flutter/material.dart';
import 'package:annotations/infra/date/format_date.dart';
import 'package:annotations/infra/debounce.dart';
import 'package:annotations/presentation/app_tab_base.dart';
import 'package:annotations/presentation/tab.dart';
import 'package:annotations/presentation/textfield.dart';
import 'note_Bloc.dart';

class NotePage extends StatefulWidget {
  NoteBloc noteBloc;
  NotePage({Key key,this.noteBloc}) : super(key: key){

  }

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> with WidgetsBindingObserver {

  final _debouncer = Debouncer(milliseconds: 500);

  DateTime newDateTime;

  @override
  void initState() {
    widget.noteBloc.initNote();
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      body:new StreamBuilder(stream: widget.noteBloc.note, builder: (context, AsyncSnapshot<Note> snapshot)
              => renderAppTabLayouTbuild(context,[
        Container(
          margin: const EdgeInsets.only(bottom: 25.0),
          child: Text(formatData(widget.noteBloc.date),
            style: renderStyleApp())),
          TextFieldApp(widget.noteBloc.currentNote.text,"Inicie sua anotação",
           (text) {_debouncer.run(() => widget.noteBloc.saveNoteOrUpdate(text));})
                  ])),
                  bottomNavigationBar:TabApp(controller:widget.noteBloc,iconMode: Icons.view_column) ,
                  );
  }
}

