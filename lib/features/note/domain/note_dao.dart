import 'package:floor/floor.dart';

import 'note_entity.dart';

 @dao
 abstract class NoteDao {

   @Query('SELECT * FROM Note WHERE date = :date')
   Future<Note> findNoteByDate(String date);

   @Query('SELECT * FROM Note')
   Future<List<Note>> findAll();

   @insert
   Future<int> insertNote(Note note);

   @update
   Future<int> updateNote(Note note);
 }