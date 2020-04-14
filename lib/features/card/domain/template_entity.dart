import 'package:floor/floor.dart';

@entity
 class Template {
   @primaryKey
   final int id;

   final String titulo;

   Template(this.id, this.titulo);
 }