import 'package:annotations/features/card/domain/card_dao.dart';
import 'package:annotations/features/card/domain/card_entity.dart';
import 'package:annotations/features/card/domain/template_dao.dart';
import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:annotations/infra/container.dart';
import 'package:annotations/infra/database.dart';
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
  await AppContainer.initialise();
  kiwi.Container container = kiwi.Container();
  group('database tests Card', () {
    AppDatabase database;
    CardDao cardDao;
    TemplateDao templateDao;
    
    setUp(() async {
       database = await container.resolve<Future<AppDatabase>>('testDatabase');
       templateDao = database.templateDao;
       cardDao = database.cardDao;
    });

    tearDown(() async {
      await database.close();
    });

    test('insert and list all Template', () async {
      Template template = Template(null,"titulo");
      int id = await templateDao.insertTemplate(template);

      List<Template> templates = await templateDao.findAll();
      expect(templates.length, equals(1));
    });

    test('insert and findByDate Template', () async {
      Template template = Template(null,"titulo");
      int id = await templateDao.insertTemplate(template);


      List<Template> templateFound = await templateDao.findAll();
      expect(templateFound[0].titulo, equals(template.titulo));
    });

    test('update and findByDate Template', () async {
      Template template = Template(null,"titulo");
      int id = await templateDao.insertTemplate(template);


      List<Template> templateFound = await templateDao.findAll();
      Template templateUpdate = new Template(templateFound[0].id,'update test');
      await templateDao.updateTemplate(templateUpdate); 

      templateFound = await templateDao.findAll();
      expect(templateFound[0].titulo, equals('update test'));
      expect(templateFound.length, equals(1));
    });



    test('insert and list all Card', () async {
      Template template = Template(null,"titulo");
      int id = await templateDao.insertTemplate(template);
      final card = Card(null,"04-03-2020",id, 'text card');
      await cardDao.insertCard(card);


      List<Card> cards = await cardDao.findAll();
      expect(cards.length, equals(1));
    });
    test('insert and findByDate Card', () async {
      Template template = Template(null,"titulo");
      int id = await templateDao.insertTemplate(template);
      final card = Card(null,"04-03-2020",id, 'create test');
      await cardDao.insertCard(card);


      Card cardFound = await cardDao.findCardByDateAndTemplateId("04-03-2020",id);
      expect(cardFound.text, equals(card.text));
    });
    test('update and  findByDate Card', () async {
      Template template = Template(null,"titulo");
      int id = await templateDao.insertTemplate(template);
      final card = Card(null,"04-03-2020",id, 'create test',);
      await cardDao.insertCard(card);
      
      Card cardFound = await cardDao.findCardByDateAndTemplateId("04-03-2020",id);
      Card cardUpdate = new Card(cardFound.id,cardFound.date,id,'update test');
      await cardDao.updateCard(cardUpdate); 
      
      cardUpdate = await cardDao.findCardByDateAndTemplateId("04-03-2020",id);
      expect(cardUpdate.text, equals('update test'));

      List<Card> cardsFound = await cardDao.findAll();
      expect(cardsFound.length, equals(1));
    });
  });
}