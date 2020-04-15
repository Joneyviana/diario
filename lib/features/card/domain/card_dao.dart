 import 'package:floor/floor.dart';

import 'card_entity.dart';

@dao
 abstract class CardDao {

   @Query('SELECT * FROM Card WHERE date = :date AND template_id = :templateId')
   Future<Card> findCardByDateAndTemplateId(String date, int templateId);

   @Query('SELECT * FROM Card')
   Future<List<Card>> findAll();

   @Query('SELECT * FROM Card WHERE id = :id')
   Future<Card> findById(int id);

   @Query('DELETE FROM Card')
   Future<void> deleteAll();

   @insert
   Future<int> insertCard(Card card);

   @update
   Future<int> updateCard(Card card);
 }