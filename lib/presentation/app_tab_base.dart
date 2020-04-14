import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

  renderAppTabLayouTbuild(BuildContext context,List<Widget> content, Widget tabBar) {
    print("renderizou");
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                  child: Column(children:content)
            )
          )
        ),
        tabBar //tabBar
      ])
    );

                    
  }