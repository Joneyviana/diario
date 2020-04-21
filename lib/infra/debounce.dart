import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({ this.milliseconds });

  run(VoidCallback action) {
    dispose();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  
  }
  void dispose(){
    if (_timer != null) {
      _timer.cancel();
    }
  }
}