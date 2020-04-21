import 'package:annotations/features/card/domain/card_dao.dart';
import 'package:annotations/features/card/domain/card_entity.dart';
import 'package:annotations/features/card/domain/card_repository.dart';
import 'package:annotations/features/card/domain/template_card.dart';
import 'package:annotations/features/card/domain/template_dao.dart';
import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:annotations/features/card/presentation/card_controller.dart';
import 'package:annotations/features/note/domain/note_dao.dart';
import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:annotations/features/note/presentation/note_controller.dart';
import 'package:annotations/infra/container.dart';
import 'package:annotations/infra/database.dart';
import 'package:annotations/infra/date/format_date.dart';
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
  NoteDao noteDao;
  await AppContainer.initialise();
  kiwi.Container container = kiwi.Container();
  
  group('NoteController tests', () {
    AppDatabase database;
    NoteController noteController;
    setUp(() async {
       
       database = await container.resolve<Future<AppDatabase>>('testDatabase');
       noteDao = database.noteDao;
       noteController = await container.resolve<Future<NoteController>>('testNoteController');
    });

    tearDown(() async {
      await database.close();
    });

    test('insert note', () async {
      await noteController.getOfDay(DateTime.now());
      await noteController.saveNoteOrUpdate("teste");
      List<Note> templates = await noteDao.findAll();
      expect(templates.length, equals(1));
      expect(templates[0].text, equals("teste"));
      
    });

     test('update note', () async {
      await noteController.getOfDay(DateTime.now());
      await noteController.saveNoteOrUpdate("teste");
      await noteController.saveNoteOrUpdate("teste update");
      List<Note> templates = await noteDao.findAll();
      expect(templates.length, equals(1));
      expect(templates[0].text, equals("teste update"));
      
    });

    test('get Note', () async {
       await noteController.getOfDay(DateTime.now());
       await noteController.saveNoteOrUpdate("teste");
       await noteController.saveNoteOrUpdate("teste update");
       await noteController.getOfDay(DateTime.now());
       expect(noteController.currentNote.text,equals("teste update"));
    });

    test('previus Note', () async {
       Note  note = Note(null,formatData(DateTime.now().subtract(Duration(days: 1))),"titulo");
       int id = await noteDao.insertNote(note);
       
       await noteController.getOfDay(DateTime.now());
       await noteController.previous();
       expect(noteController.note.text,equals("titulo"));
    });

    test('next Note', () async {
        Note  note = Note(null,formatData(DateTime.now().add(Duration(days: 1))),"titulo");
       int id = await noteDao.insertNote(note);
       
       await noteController.getOfDay(DateTime.now());
       await noteController.next();
       expect(noteController.note.text,equals("titulo"));
    });
  });
}