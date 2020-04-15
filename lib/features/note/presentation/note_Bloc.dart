
import 'package:annotations/features/card/presentation/card_controller.dart';
import 'package:annotations/features/note/domain/note_builder.dart';
import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:annotations/features/note/domain/note_repository.dart';
import 'package:annotations/presentation/tab_base_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:rxdart/rxdart.dart';


class NoteBloc implements TabBaseController{
  NoteRepository noteRepository;

  BehaviorSubject<Note> note;

  NoteBloc(NoteRepository noteRepository) {
     this.noteRepository = noteRepository;
     this.note = new BehaviorSubject<Note>.seeded(builderEmptyNote());
  }

  Note currentNote = builderEmptyNote() ;


  DateTime date = DateTime.now();
  
  kiwi.Container container = kiwi.Container();
   
  Future<void> initNote() async {
    
    CardController cardController = await container.resolve<Future<CardController>>();
    date = cardController.date;
    currentNote = await noteRepository.getNoteOfDay(date);
    note.sink.add(currentNote);
  }

  Future<void> previous() async {
    var _date = date.subtract(Duration(days: 1)); 
    currentNote = await noteRepository.getNoteOfDay(_date);
    note.sink.add(currentNote);
    this.date = _date;
  }

  Future<void> next() async {
    var _date = date.add(Duration(days: 1));
    currentNote = await noteRepository.getNoteOfDay(_date);
    note.sink.add(currentNote);
    this.date = _date;
  }

  Future<void> getOfDay(DateTime _date) async {
    currentNote = await noteRepository.getNoteOfDay(_date);
    note.sink.add(currentNote);
    this.date = _date;
  }

  void saveNoteOrUpdate(String texto) async{
    currentNote = new Note(currentNote.id,currentNote.date,texto);
    noteRepository.save(texto,date);
  }
}