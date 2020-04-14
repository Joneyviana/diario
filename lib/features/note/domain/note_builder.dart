import 'package:annotations/infra/date/format_date.dart';

import 'note_entity.dart';

Note builderEmptyNote(){
  return Note(null,formatData(DateTime.now()),"");
}