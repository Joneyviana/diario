import 'package:flutter/material.dart';

class Loading{

  void onLoading(BuildContext context,Function f) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );
    await f();
    Navigator.pop(context);
  
}

}