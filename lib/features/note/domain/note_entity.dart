 import 'package:floor/floor.dart';

 @entity
 class Note {
   @primaryKey
   final int id;

   final String date;

   final String text;

   Note(this.id, this.date,this.text);
 }