
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

import 'features/card/presentation/card_controller.dart';
import 'features/card/presentation/card_page.dart';
import 'features/login/presentation/login_page.dart';
import 'features/note/presentation/note_Bloc.dart';
import 'features/note/presentation/note_controller.dart';
import 'features/note/presentation/note_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'infra/container.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppContainer.initialise();
  kiwi.Container container = kiwi.Container();
  NoteBloc noteController = await container.resolve<Future<NoteBloc>>();
  CardController cardController = await container.resolve<Future<CardController>>();
  runApp(MaterialApp(
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    
       localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('pt', 'PT'),
      supportedLocales: [
        const Locale('pt', 'PT'), // English
      ],
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => NotePage(noteBloc:noteController),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/note': (context) => NotePage(noteBloc:noteController),
      '/card': (context) => CardPage(cardController:cardController),
    },
  ));
}


