 import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:floor/floor.dart';

 @Entity(tableName: 'card',
  foreignKeys: [
    ForeignKey(
      childColumns: ['template_id'],
      parentColumns: ['id'],
      entity: Template,
    )
  ],
)
 class Card {
   @primaryKey
   final int id;

   final String date;

   int template_id;

   final String text;

   Card(this.id, this.date,this.template_id,this.text);
 }