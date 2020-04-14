// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardController on CardStore, Store {
  Computed<int> _$sizeComputed;

  @override
  int get size => (_$sizeComputed ??= Computed<int>(() => super.size)).value;
  Computed<List<String>> _$titulosComputed;

  @override
  List<String> get titulos =>
      (_$titulosComputed ??= Computed<List<String>>(() => super.titulos)).value;
  Computed<List<String>> _$textosComputed;

  @override
  List<String> get textos =>
      (_$textosComputed ??= Computed<List<String>>(() => super.textos)).value;

  final _$dateAtom = Atom(name: 'CardStore.date');

  @override
  DateTime get date {
    _$dateAtom.context.enforceReadPolicy(_$dateAtom);
    _$dateAtom.reportObserved();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.context.conditionallyRunInAction(() {
      super.date = value;
      _$dateAtom.reportChanged();
    }, _$dateAtom, name: '${_$dateAtom.name}_set');
  }

  final _$templateCardsAtom = Atom(name: 'CardStore.templateCards');

  @override
  List<TemplateCard> get templateCards {
    _$templateCardsAtom.context.enforceReadPolicy(_$templateCardsAtom);
    _$templateCardsAtom.reportObserved();
    return super.templateCards;
  }

  @override
  set templateCards(List<TemplateCard> value) {
    _$templateCardsAtom.context.conditionallyRunInAction(() {
      super.templateCards = value;
      _$templateCardsAtom.reportChanged();
    }, _$templateCardsAtom, name: '${_$templateCardsAtom.name}_set');
  }

  final _$noteAtom = Atom(name: 'CardStore.note');

  @override
  Note get note {
    _$noteAtom.context.enforceReadPolicy(_$noteAtom);
    _$noteAtom.reportObserved();
    return super.note;
  }

  @override
  set note(Note value) {
    _$noteAtom.context.conditionallyRunInAction(() {
      super.note = value;
      _$noteAtom.reportChanged();
    }, _$noteAtom, name: '${_$noteAtom.name}_set');
  }

  final _$initTemplateAsyncAction = AsyncAction('initTemplate');

  @override
  Future<void> initTemplate() {
    return _$initTemplateAsyncAction.run(() => super.initTemplate());
  }

  final _$previousAsyncAction = AsyncAction('previous');

  @override
  Future<void> previous() {
    return _$previousAsyncAction.run(() => super.previous());
  }

  final _$nextAsyncAction = AsyncAction('next');

  @override
  Future<void> next() {
    return _$nextAsyncAction.run(() => super.next());
  }

  final _$getOfDayAsyncAction = AsyncAction('getOfDay');

  @override
  Future<void> getOfDay(DateTime date) {
    return _$getOfDayAsyncAction.run(() => super.getOfDay(date));
  }

  final _$insertTemplateAsyncAction = AsyncAction('insertTemplate');

  @override
  Future<void> insertTemplate(String texto) {
    return _$insertTemplateAsyncAction.run(() => super.insertTemplate(texto));
  }

  final _$updateTemplateAsyncAction = AsyncAction('updateTemplate');

  @override
  Future<void> updateTemplate(int position, String texto) {
    return _$updateTemplateAsyncAction
        .run(() => super.updateTemplate(position, texto));
  }

  final _$CardStoreActionController = ActionController(name: 'CardStore');

  @override
  Future<void> saveNoteOrUpdateCard(int position, String texto) {
    final _$actionInfo = _$CardStoreActionController.startAction();
    try {
      return super.saveNoteOrUpdateCard(position, texto);
    } finally {
      _$CardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'date: ${date.toString()},templateCards: ${templateCards.toString()},note: ${note.toString()},size: ${size.toString()},titulos: ${titulos.toString()},textos: ${textos.toString()}';
    return '{$string}';
  }
}
