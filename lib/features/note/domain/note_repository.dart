import 'package:annotations/infra/database.dart';
import 'package:annotations/infra/date/format_date.dart';

import 'note_builder.dart';
import 'note_dao.dart';
import 'note_entity.dart';

class NoteRepository {
  Note note;
  NoteDao noteDao;


  NoteRepository(AppDatabase database){
    noteDao = database.noteDao;
  }

  Future<Note> getNoteOfDay(DateTime date)  async {
    this.note = await noteDao.findNoteByDate(formatData(date));
    if(this.note == null){
      return builderEmptyNote();
    }
      return this.note;
  }

  Future<void> save(String texto,DateTime date) async {
    if(this.note == null){
      note = await getNoteOfDay(date);
      if(note.id == null){
        int id = await noteDao.insertNote(Note(null,formatData(date),texto));
        this.note = Note(id,formatData(date),texto);
      }
      
     }
    else{
      this.note = Note(this.note.id,formatData(date),texto);
      noteDao.updateNote(this.note);
     }
  }

}