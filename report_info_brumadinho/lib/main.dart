import 'package:flutter/material.dart';

//Páginas
import 'package:report_info_brumadinho/index.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Report Info - Brumadinho",
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Index(),
      },
    )
  );
}