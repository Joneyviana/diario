// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteController on NoteStore, Store {
  Computed<String> _$textoComputed;

  @override
  String get texto =>
      (_$textoComputed ??= Computed<String>(() => super.texto)).value;

  final _$dateAtom = Atom(name: 'NoteStore.date');

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

  final _$notesAtom = Atom(name: 'NoteStore.notes');

  @override
  List<Note> get notes {
    _$notesAtom.context.enforceReadPolicy(_$notesAtom);
    _$notesAtom.reportObserved();
    return super.notes;
  }

  @override
  set notes(List<Note> value) {
    _$notesAtom.context.conditionallyRunInAction(() {
      super.notes = value;
      _$notesAtom.reportChanged();
    }, _$notesAtom, name: '${_$notesAtom.name}_set');
  }

  final _$noteAtom = Atom(name: 'NoteStore.note');

  @override
  Note get note {
    _$noteAtom.context.enforceReadPolicy(_$noteAtom);
    return super.note;
  }

  @override
  set note(Note value) {
    _$noteAtom.context.conditionallyRunInAction(() {
      super.note = value;
      _$noteAtom.reportChanged();
    }, _$noteAtom, name: '${_$noteAtom.name}_set');
  }

  final _$initNoteAsyncAction = AsyncAction('initNote');

  @override
  Future<void> initNote() {
    return _$initNoteAsyncAction.run(() => super.initNote());
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
  Future<void> getOfDay(DateTime _date) {
    return _$getOfDayAsyncAction.run(() => super.getOfDay(_date));
  }

  @override
  String toString() {
    final string =
        'date: ${date.toString()},notes: ${notes.toString()},note: ${note.toString()},texto: ${texto.toString()}';
    return '{$string}';
  }
}
