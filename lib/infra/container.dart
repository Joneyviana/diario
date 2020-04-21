import 'package:annotations/features/card/domain/card_repository.dart';
import 'package:annotations/features/card/presentation/card_controller.dart';
import 'package:annotations/features/note/domain/note_repository.dart';
import 'package:annotations/features/note/presentation/note_Bloc.dart';
import 'package:annotations/features/note/presentation/note_controller.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'database.dart';

class AppContainer {
  static Future<void> initialise() async {
    

    kiwi.Container container = kiwi.Container();
    
    container.registerFactory((_) async => 
      await $FloorAppDatabase.inMemoryDatabaseBuilder()
        .build(),name:'testDatabase');

    container.registerSingleton((_) async => 
      await $FloorAppDatabase.databaseBuilder('diario_anotation.db').build());

    container.registerFactory((c) async => new NoteRepository( 
      await c.resolve<Future<AppDatabase>>('testDatabase')),name:"testNote");
     
    container.registerSingleton((c) async => new NoteRepository(
      await c.resolve<Future<AppDatabase>>())); 

    container.registerFactory((c) async => new CardRepository(
      await c.resolve<Future<AppDatabase>>('testDatabase')),name:'testCard');   

    container.registerSingleton((c) async => new CardRepository(
      await c.resolve<Future<AppDatabase>>())); 

    container.registerFactory((c) async => new NoteBloc(
      await c.resolve<Future<NoteRepository>>('testNote')),name:'testNoteBloc');   

    container.registerFactory((c) async => new NoteController(
      await c.resolve<Future<NoteRepository>>('testNote')),name:'testNoteController');     

    container.registerFactory((c) async => new NoteController(
      await c.resolve<Future<NoteRepository>>()));  

    container.registerFactory((c) async => new NoteBloc(
      await c.resolve<Future<NoteRepository>>()));    

     container.registerFactory((c) async => new CardController(
      await c.resolve<Future<CardRepository>>('testCard')), name:'testCardController');    

    container.registerSingleton((c) async => new CardController(
      await c.resolve<Future<CardRepository>>())); 

       

  }


}