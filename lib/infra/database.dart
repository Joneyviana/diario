import 'dart:async';
import 'package:annotations/features/card/domain/card_dao.dart';
import 'package:annotations/features/card/domain/card_entity.dart';
import 'package:annotations/features/card/domain/template_dao.dart';
import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:annotations/features/note/domain/note_dao.dart';
import 'package:annotations/features/note/domain/note_entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Note,Card,Template])
 abstract class AppDatabase extends FloorDatabase {
   NoteDao get noteDao;

   CardDao get cardDao;

   TemplateDao get templateDao;
 }