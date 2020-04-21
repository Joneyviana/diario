
import 'package:annotations/features/card/presentation/card_controller.dart';
import 'package:annotations/features/note/domain/note_builder.dart';
import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:annotations/features/note/domain/note_repository.dart';
import 'package:annotations/presentation/tab_base_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

part 'note_controller.g.dart';

class NoteController = NoteStore with _$NoteController;

abstract class NoteStore with Store implements TabBaseController{
  NoteRepository noteRepository;

  NoteStore(NoteRepository noteRepository) {
     this.noteRepository = noteRepository;
  }

  Note currentNote ;

  @observable
  DateTime date = DateTime.now();
  
  @observable
  List<Note> notes ;

  @observable 
  Note note = builderEmptyNote();
  
  
  kiwi.Container container = kiwi.Container();
  
  @action 
  Future<void> initNote() async {
    
    CardController cardController = await container.resolve<Future<CardController>>();
    date = cardController.date;
    note = await noteRepository.getNoteOfDay(date);
  }

  @action 
  Future<void> previous() async {
    var _date = date.subtract(Duration(days: 1)); 
     note = await noteRepository.getNoteOfDay(_date);
     this.date = _date;
  }

  @action
  Future<void> next() async {
    var _date = date.add(Duration(days: 1));
    note = await noteRepository.getNoteOfDay(_date); 
    this.date = _date;
  }

  @computed
  String get texto  => note.text;

  @action
  Future<void> getOfDay(DateTime _date) async {
    note = await noteRepository.getNoteOfDay(_date); 
    this.date = _date;
  }

  void updateNote(){
    this.note = currentNote;
  }

  Future<void> saveNoteOrUpdate(String texto) async {
    print("save note");
    currentNote = new Note(this.note.id,this.note.date,texto);
    await noteRepository.save(texto,date);
  }
}