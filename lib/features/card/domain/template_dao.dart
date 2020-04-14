 import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:floor/floor.dart';

import 'card_entity.dart';

@dao
 abstract class TemplateDao {


   @Query('SELECT * FROM Template')
   Future<List<Template>> findAll();

   @insert
   Future<int> insertTemplate(Template template);

   @update
   Future<int> updateTemplate(Template template);
 }