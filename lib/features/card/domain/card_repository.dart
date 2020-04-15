import 'package:annotations/features/card/domain/template_card.dart';
import 'package:annotations/features/card/domain/template_dao.dart';
import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:annotations/infra/database.dart';
import 'package:annotations/infra/date/format_date.dart';

import 'card_dao.dart';
import 'card_entity.dart';


class CardRepository {
  Card card;
  CardDao cardDao;
  TemplateDao templateDao;
  List<Template> templates;


  CardRepository(AppDatabase database){
    cardDao = database.cardDao;
    templateDao = database.templateDao;
    //cardDao.deleteAll();
  }

  Future<List<Future<TemplateCard>>> getTemplateCard(DateTime date) async{
    templates = await templateDao.findAll();
    return templates.map((template) async  => new TemplateCard(template.id,template.titulo,
       await getCard(date,template.id))).toList();
  }

  Future<Card> getCard(DateTime date,int templateId)  async {
    this.card = await cardDao.findCardByDateAndTemplateId(formatData(date),templateId);
    if(this.card == null){
      return builderEmptyCard(templateId);
    }
      return this.card;
  }

   Card builderEmptyCard(int template){
     return new Card(null,formatData(DateTime.now()),template,"");
   }

   Future<void> deleteTemplate(int id) async{
     return await templateDao.deleteTemplate(id);
   }

  Future<int> saveCard( Card card) async {
    if(card.id == null){
       card = await getCard(DateTime.parse(card.date),card.template_id);
       if(card.id == null){
         return cardDao.insertCard(card);
       }
    }
    else {
       return cardDao.updateCard(card);
    }
  }

    Future<int> saveTemplate(Template template) async {
    if(template.id == null){
       return templateDao.insertTemplate(template);
    }
    else {
       return templateDao.updateTemplate(template);
    }
  
  }

}