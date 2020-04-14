import 'package:annotations/features/card/domain/card_dao.dart';
import 'package:annotations/features/card/domain/card_entity.dart';
import 'package:annotations/features/card/domain/card_repository.dart';
import 'package:annotations/features/card/domain/template_card.dart';
import 'package:annotations/features/card/domain/template_dao.dart';
import 'package:annotations/features/card/domain/template_entity.dart';
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
  
  group('CardRepository tests', () {
    AppDatabase database;
    CardRepository cardRepository;
    setUp(() async {
       
       database = await container.resolve<Future<AppDatabase>>('testDatabase');
       templateDao = database.templateDao;
       cardDao = database.cardDao;
       cardRepository = await container.resolve<Future<CardRepository>>('testCard');
    });

    tearDown(() async {
      await database.close();
    });

    test('insert template', () async {
      int id = await cardRepository.saveTemplate(new Template(null,"teste"));
      List<Template> templates = await templateDao.findAll();
      expect(templates.length, equals(1));
      
    });

     test('update template', () async {
      int id = await cardRepository.saveTemplate(new Template(null,"teste"));
      id = await cardRepository.saveTemplate(new Template(id,"update teste"));
      List<Template> templates = await templateDao.findAll();
      expect(templates.length, equals(1));
      expect(templates[0].titulo, equals("update teste"));
      
    });

    test('list template', () async {
       int id = await cardRepository.saveTemplate(new Template(null,"teste"));
       int idCard = await cardRepository.saveCard(new Card(null,formatData(DateTime.now()),id, 'create test'));
       List<Future<TemplateCard>> cardsTemplates  = await cardRepository.getTemplateCard(DateTime.now());
       TemplateCard templatecard = await cardsTemplates[0];
    
       await cardRepository.saveCard(new Card(idCard,formatData(DateTime.now()),id, 'update test'));
       await cardRepository.saveTemplate(new Template(null,"teste update"));
       await cardRepository.saveTemplate(new Template(null,"sem card"));
       cardsTemplates  = await cardRepository.getTemplateCard(DateTime.now());
       templatecard = await cardsTemplates[0];
       expect(templatecard.card.text,equals('update test'));
       templatecard = await cardsTemplates[1];
       expect(templatecard.titulo,equals("teste update"));
       templatecard = await cardsTemplates[2];
       expect(templatecard.card.text,equals(''));
    });

    test('insert card', () async {
      int id = await cardRepository.saveTemplate(new Template(null,"teste"));
      await cardRepository.saveCard(new Card(null,formatData(DateTime.now()),id, 'create test'));
      Card noteFound = await cardRepository.getCard(DateTime.now(),id);
      expect(noteFound.text, equals("create test"));
    });
    test('update card', () async {
      int idTemplate = await cardRepository.saveTemplate(new Template(null,"teste"));
      int id = await cardRepository.saveCard(new Card(null,formatData(DateTime.now()),idTemplate, 'create test'));
      await cardRepository.saveCard(new Card(id,formatData(DateTime.now()),idTemplate, 'update test'));
      Card cardFound = await cardRepository.getCard(DateTime.now(),idTemplate);
      
      List<Card> cards = await cardDao.findAll();
      expect(cards.length, equals(1));
      expect(cardFound.text, equals('update test'));
    });
  });
}