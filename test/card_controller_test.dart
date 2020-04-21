import 'package:annotations/features/card/domain/card_dao.dart';
import 'package:annotations/features/card/domain/card_entity.dart';
import 'package:annotations/features/card/domain/card_repository.dart';
import 'package:annotations/features/card/domain/template_card.dart';
import 'package:annotations/features/card/domain/template_dao.dart';
import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:annotations/features/card/presentation/card_controller.dart';
import 'package:annotations/infra/container.dart';
import 'package:annotations/infra/database.dart';
import 'package:annotations/infra/date/format_date.dart';
import 'package:floor/floor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

// your imports follow here

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();
  TemplateDao templateDao;
  CardDao cardDao;
  await AppContainer.initialise();
  kiwi.Container container = kiwi.Container();
  
  group('cardController tests', () {
    AppDatabase database;
    CardController cardController;
    setUp(() async {
       
       database = await container.resolve<Future<AppDatabase>>('testDatabase');
       templateDao = database.templateDao;
       cardDao = database.cardDao;
       cardController = await container.resolve<Future<CardController>>('testCardController');
    });

    tearDown(() async {
      await database.close();
    });

    test('insert template', () async {
      await cardController.getTemplate(DateTime.now());
      await cardController.insertTemplate("teste");
      List<Template> templates = await templateDao.findAll();
      expect(templates.length, equals(1));
      expect(templates[0].titulo, equals("teste"));
      
    });

     test('update template', () async {
       await cardController.getTemplate(DateTime.now());
       await cardController.insertTemplate("teste");
       await cardController.updateTemplate(0,"teste update");
      List<Template> templates = await templateDao.findAll();
      expect(templates.length, equals(1));
      expect(templates[0].titulo, equals("teste update"));
      
    });

    test('list template', () async {
       await cardController.getTemplate(DateTime.now());
       await cardController.insertTemplate("teste");
       await cardController.saveNoteOrUpdateCard(0,"Meu cartão");
       await cardController.getTemplate(DateTime.now());
       expect(cardController.templateCards[0].card.text,equals("Meu cartão"));
    });

    test('previus template', () async {
       Template template = Template(null,"titulo");
       int id = await templateDao.insertTemplate(template);
       final card = Card(null,formatData(DateTime.now().subtract(Duration(days: 1))),id, 'create test');
       await cardDao.insertCard(card);
       
       await cardController.getTemplate(DateTime.now());
       await cardController.previous();
       expect(cardController.templateCards[0].card.text,equals('create test'));
    });

    test('next template', () async {
       Template template = Template(null,"titulo");
       int id = await templateDao.insertTemplate(template);
       final card = Card(null,formatData(DateTime.now().add(Duration(days: 1))),id, 'create test 1');
       await cardDao.insertCard(card);
       
       await cardController.getTemplate(DateTime.now());
       await cardController.next();
       expect(cardController.templateCards[0].card.text,equals('create test 1'));
    });

    test('insert card', () async {
       await cardController.getTemplate(DateTime.now());
       await cardController.insertTemplate("teste");
       await cardController.saveNoteOrUpdateCard(0,"Meu cartão");
       List<Card> cardsFound = await cardDao.findAll();
      expect(cardsFound.length, equals(1));

      await cardController.getTemplate(DateTime.now());
      Card cardFound = await cardDao.findCardByDateAndTemplateId(
        formatData(DateTime.now()),cardController.templateCards[0].id);
       expect(cardFound.text, equals("Meu cartão"));  
      
    });
    test('update card', () async {
      await cardController.getTemplate(DateTime.now());
      await cardController.insertTemplate("teste");
       await cardController.saveNoteOrUpdateCard(0,"Meu cartão");
       await cardController.saveNoteOrUpdateCard(0,"Update cartão");
       List<Card> cardsFound = await cardDao.findAll();
      expect(cardsFound.length, equals(1));

      await cardController.getTemplate(DateTime.now());
      Card cardFound = await cardDao.findCardByDateAndTemplateId(
        formatData(DateTime.now()),cardController.templateCards[0].id);
       expect(cardFound.text, equals("Update cartão"));  
    });
  });
}