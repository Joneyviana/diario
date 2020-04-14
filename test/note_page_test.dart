import 'package:annotations/features/note/presentation/note_controller.dart';
import 'package:annotations/features/note/presentation/note_page.dart';
import 'package:annotations/infra/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void main() async {
  await AppContainer.initialise();
  kiwi.Container container = kiwi.Container();
  
  group('note widget tests', () {
    NoteController noteController;
    setUp(() async {
       noteController = await container.resolve<Future<NoteController>>();
       
    });
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(NotePage(noteController:noteController));
    await tester.enterText(find.byType(TextField), 'hi');
    
    tester.tap(find.text("test"));
    tester.tap(find.text("test"));
    tester.tap(find.text("test"));
    tester.tap(find.text("test"));

  });
});
}