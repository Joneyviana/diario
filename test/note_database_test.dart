import 'package:annotations/features/note/domain/note_dao.dart';
import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:annotations/infra/container.dart';
import 'package:annotations/infra/database.dart';
import 'package:floor/floor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

// your imports follow here

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();
   await AppContainer.initialise();
  kiwi.Container container = kiwi.Container();
  group('database tests Note', () {
    AppDatabase database;
    NoteDao noteDao;
    setUp(() async {
       
       database = await container.resolve<Future<AppDatabase>>('testDatabase');;
       noteDao = database.noteDao;
    });

    tearDown(() async {
      await database.close();
    });

    test('insert and list all Note', () async {
      final note = Note(null,"04-03-2020", 'Simon');
      await noteDao.insertNote(note);


      List<Note> notes = await noteDao.findAll();
      expect(notes.length, equals(1));
    });
    test('insert and findByDate Note', () async {
      final note = Note(null,"04-03-2020", 'create test');
      await noteDao.insertNote(note);


      Note noteFound = await noteDao.findNoteByDate("04-03-2020");
      expect(noteFound.text, equals(note.text));
    });
    test('update and  findByDate Note', () async {
      final note = Note(null,"04-03-2020", 'create test');
      await noteDao.insertNote(note);
      
      Note noteFound = await noteDao.findNoteByDate("04-03-2020");
      Note noteUpdate = new Note(noteFound.id,noteFound.date,'update test');
      await noteDao.updateNote(noteUpdate); 
      
      noteUpdate = await noteDao.findNoteByDate("04-03-2020");
      expect(noteUpdate.text, equals('update test'));
    });
  });
}