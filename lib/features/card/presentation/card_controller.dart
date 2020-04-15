
import 'package:annotations/features/card/domain/card_entity.dart';
import 'package:annotations/features/card/domain/card_repository.dart';
import 'package:annotations/features/card/domain/template_card.dart';
import 'package:annotations/features/card/domain/template_entity.dart';
import 'package:annotations/features/note/domain/note_builder.dart';
import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:annotations/features/note/presentation/note_controller.dart';
import 'package:annotations/presentation/tab_base_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

part 'card_controller.g.dart';

class CardController = CardStore with _$CardController;

abstract class CardStore with Store implements TabBaseController{
  CardRepository cardRepository;

  CardStore(CardRepository cardRepository) {
     this.cardRepository = cardRepository;
  }

  @observable
  DateTime date = DateTime.now();
  
  @observable
  List<TemplateCard> templateCards = List<TemplateCard>() ;

  List<TemplateCard> currentTemplateCards;

  @observable 
  Note note = builderEmptyNote();

  kiwi.Container container = kiwi.Container();
  
  @action 
  Future<void> initTemplate() async {
    NoteController noteController = await container.resolve<Future<NoteController>>();
    date = noteController.date;
    this.getTemplate(date);
    
  }
  Future<void> getTemplate(DateTime date) async {
    currentTemplateCards = List<TemplateCard>();
    var _templatesAsync = await cardRepository.getTemplateCard(date);
    for(var i=0; i<_templatesAsync.length; i++){
      var template = await _templatesAsync[i];
      currentTemplateCards.add(template);
    }
    this.templateCards = currentTemplateCards;
  }

  @action 
  Future<void> previous() async {
     var _date = date.subtract(Duration(days: 1)); 
     await this.getTemplate(_date);
     this.date = _date;
  }

  @action
  Future<void> next() async {
    var _date = date.add(Duration(days: 1));
    await this.getTemplate(_date);
    this.date = _date;
    
  }

  @action
  Future<void> getOfDay(DateTime date) async {
    await this.getTemplate(date);
    this.date = date;
  }

  @action
  Future<void> saveNoteOrUpdateCard(int position, String texto) {
    Card card = templateCards[position].card;
    templateCards[position].card = new Card(card.id,card.date,templateCards[position].id,texto);
    cardRepository.saveCard(new Card(card.id,card.date,templateCards[position].id,texto));
  }
  
  @action
  Future<void> insertTemplate( String texto) async {
     int id = await cardRepository.saveTemplate(new Template(null,texto));
     currentTemplateCards.add(new TemplateCard(id, texto, await cardRepository.getCard(this.date,id))); 
     templateCards = currentTemplateCards;

  }
  @action
  Future<void> deleteTemplate(int position) async {
     await cardRepository.deleteTemplate(templateCards[position].id);
     currentTemplateCards.removeAt(position);
     templateCards = currentTemplateCards;
  }

  @action
  Future<void> updateTemplate(int position, String texto) async {
    await cardRepository.saveTemplate(new Template(templateCards[position].id,texto));
    templateCards[position].titulo = texto ;
  

  }

}