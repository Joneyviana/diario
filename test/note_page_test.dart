import 'package:annotations/features/note/presentation/note_Bloc.dart';
import 'package:annotations/features/note/presentation/note_controller.dart';
import 'package:annotations/features/note/presentation/note_page.dart';
import 'package:annotations/infra/container.dart';
import 'package:annotations/infra/date/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();
  await AppContainer.initialise();
  kiwi.Container container = kiwi.Container();
  
  group('note widget tests', () {
    NoteBloc noteController;
    setUp(() async {
       noteController = await container.resolve<Future<NoteBloc>>('testNoteBloc');
       
    });
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home:NotePage(noteBloc:noteController)));
    await tester.enterText(find.byType(TextField).first, 'hi');
    await tester.tap(find.text("Previous"));
    expect(find.text(formatData(DateTime.now())),findsOneWidget);
    //tester.tap(find.text("Next"));
    //tester.tap(find.text("Calendar"));
    //tester.tap(find.text("Mode"));

  });
});
}