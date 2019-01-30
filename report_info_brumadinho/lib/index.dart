import 'package:flutter/material.dart';
import 'package:report_info_brumadinho/missingpeople.dart';

class Index extends StatefulWidget{
  @override
  _IndexState createState(){
    return _IndexState();
  }
}

class _IndexState extends State<Index>{

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          title: Text("Report Info - Brumadinho"),
          bottom: TabBar(
            isScrollable: true,
            tabs: <Tab>[
              Tab(text: "Pessoas Desaparecidas", icon: Icon(Icons.face)),
              Tab(text: "Animais Desaparecidos", icon: Icon(Icons.face)),
              Tab(text: "Novas Informações", icon: Icon(Icons.input)),
              Tab(text: "Sobre", icon: Icon(Icons.info)),
              Tab(text: "Contato", icon: Icon(Icons.contact_mail)),
            ],
          ),
        ),

        //BackgroundColor
        backgroundColor: Colors.grey[50],

        //Body
        body: TabBarView(
          children: <Widget>[
            MissingPeople(),
            Text(""),//MissingAnimals(),
            Text(""),//NewInformation(),
            Text(""),//About(),
            Text(""),//Contact(),
          ],
        ),
      ),
    );
  }

}