import 'package:annotations/features/note/domain/note_dao.dart';
import 'package:annotations/features/note/domain/note_entity.dart';
import 'package:annotations/infra/container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

// your imports follow here

void main() async {
  group('mobx tests', () {

    test('insert and list all Note', () async {
       Observable<String> greeting = Observable('Hello World');
       final dispose = when((_) => greeting.value == 'Hello MobX', () => print('Someone greeted MobX'));
       print("baiaku");
       final increment = Action((){
          greeting.value = 'Hello MobX';
          });
     dispose();     
    });
  });
}