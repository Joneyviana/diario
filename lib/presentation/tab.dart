import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:mobx/mobx.dart';

import 'tab_base_controller.dart';

class TabApp extends StatefulWidget {
  TabBaseController controller;
  IconData iconMode ;
  TabApp({Key key,this.controller,this.iconMode}) : super(key: key);

  @override
  TabState createState() => TabState();
}


class TabState extends State<TabApp>{
  void renderCalendar(BuildContext context) async {
    var newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
      theme: ThemeData(
          primaryColor: Colors.orangeAccent[100],
          accentColor: Colors.green[800]),
    );
    if (newDateTime != null) {
      widget.controller.getOfDay(newDateTime);
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void changeMode(){
     if(widget.iconMode == Icons.view_column){
       Navigator.pushReplacementNamed(context,"/card");
     }
     else {
      Navigator.pushReplacementNamed(context,"/note");
     }
  }

  FlatButton makeIcone(String texto,IconData icon ,Function function){
     return FlatButton(
      onPressed:function,
      color:Colors.orangeAccent[100],
      padding: EdgeInsets.all(10.0),
      child: Column( // Replace with a Row for horizontal icon + text
        children: <Widget>[
          Icon(icon),
          Text(texto)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(color: Colors.orangeAccent[100]),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                makeIcone("Previous",Icons.chevron_left,() => widget.controller.previous()),
                makeIcone("next",Icons.chevron_right,() => widget.controller.next()),
                makeIcone("Calendar",Icons.calendar_view_day,() => renderCalendar(context)),
                makeIcone("Mode",widget.iconMode, () => changeMode()),
              ],
            )
            //your elements here
            ,
        );
     
  }
}