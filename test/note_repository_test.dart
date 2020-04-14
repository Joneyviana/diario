import 'package:annotations/features/note/domain/note_dao.dart';
import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:annotations/features/note/domain/note_repository.dart';
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
  final _injector = await AppContainer.initialise();
  NoteDao noteDao;
  kiwi.Container container = kiwi.Container();
  group('NoteRepository tests', () {
    AppDatabase database;
    NoteRepository noteRepository;
    setUp(() async {
       
       database = await container.resolve<Future<AppDatabase>>('testDatabase');
       noteDao = database.noteDao;
       noteRepository = await container.resolve<Future<NoteRepository>>('testNote');
    });

    tearDown(() async {
      await database.close();
    });

    test('insert note', () async {

      await noteRepository.save("create texto",DateTime.now());
      Note noteFound = await noteRepository.getNoteOfDay(DateTime.now());
      expect(noteFound.text, equals("create texto"));
    });
    test('update note', () async {
      final note = Note(null,"04-03-2020", 'Simon');
      await noteRepository.save("create texto",DateTime.now());
      await noteRepository.save("update texto",DateTime.now());
      Note noteFound = await noteRepository.getNoteOfDay(DateTime.now());
      
      List<Note> notes = await noteDao.findAll();
      expect(notes.length, equals(1));
      expect(noteFound.text, equals('update texto'));
    });
  });
}