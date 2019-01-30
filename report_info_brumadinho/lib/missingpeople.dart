import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//conexao
import 'package:report_info_brumadinho/connection/addpeopleinfo.dart';

class MissingPeople extends StatefulWidget{
  @override
  _MissingPeopleState createState(){
    return _MissingPeopleState();
  }
}

class _MissingPeopleState extends State<MissingPeople>{

  //Variáveis Auxiliares
  Map<String, dynamic> _post;
  File _image;
  File _imageTatoo;
  File _imageScar;

  //Controles
  TextEditingController _name = TextEditingController();
  TextEditingController _cpf = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _lastContact = TextEditingController();
  TextEditingController _physicalCharacteristics = TextEditingController();
  TextEditingController _scar = TextEditingController();
  TextEditingController _tatoo = TextEditingController();
  TextEditingController _extras = TextEditingController();
  TextEditingController _nameDeclarant = TextEditingController();
  TextEditingController _phoneDeclarant = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          
          SizedBox(height: 40.0),
          Text("Informações Essenciais do Desaparecido", style: TextStyle(fontSize: 24.0),),
          SizedBox(height: 12.0),
          //Formulário
          //nome
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'nome ',
            ),
            controller: _name,
          ),
          SizedBox(height: 12.0),
          //telefone desaparecido
          TextField(
            controller: _phone,
            decoration: InputDecoration(
              filled: true,
              labelText: "telefone do desaparecido",
            )
          ),
          SizedBox(height: 12.0),
          //CPF
          TextField(
            controller: _cpf,
            decoration: InputDecoration(
              filled: true,
              labelText: "cpf",
            )
          ),
          SizedBox(height: 12.0),
          //Endereço
          TextField(
            controller: _address,
            decoration: InputDecoration(
              filled: true,
              labelText: "endereço",
            )
          ),
          SizedBox(height: 12.0),
          //Último contato
          DateTimePickerFormField(
            inputType: InputType.both,
            format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
            controller: _lastContact,
            decoration: InputDecoration(
              filled: true,
              labelText: "último contato",
            )
          ),


          SizedBox(height: 40.0),
          Text("Aparência", style: TextStyle(fontSize: 24.0),),
          //Imagem Desaparecido
          Text("Imagem do Desaparecido", style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 12.0),
          Center(
            child: _image == null
              ? Icon(Icons.image, size: 40.0,)
              : Image.file(_image),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("camera"),
                onPressed: getImageCamera,
              ),
              FlatButton(
                child: Text("galeria"),
                onPressed: getImageGallery,
              ),
            ],
          ),
          SizedBox(height: 12.0),
          //Características físicas
          TextField(
            controller: _physicalCharacteristics,
            maxLines: 5,
            decoration: InputDecoration(
              filled: true,
              labelText: "características fisicas",
            )
          ),
          SizedBox(height: 40.0),
          //Cicatriz
          TextField(
            controller: _scar,
            decoration: InputDecoration(
              filled: true,
              labelText: "possui cicatriz? qual região?",
            )
          ),
          SizedBox(height: 12.0,),
          Text("Imagem da cicatriz", style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 12.0),
          Center(
            child: _imageScar == null
              ? Icon(Icons.image, size: 40.0,)
              : Image.file(_imageScar),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("camera"),
                onPressed: getScarImageCamera,
              ),
              FlatButton(
                child: Text("galeria"),
                onPressed: getScarImageGallery,
              ),
            ],
          ),
          SizedBox(height: 40.0),
          //Tatoo
          TextField(
            controller: _tatoo,
            decoration: InputDecoration(
              filled: true,
              labelText: "possui tatuagem? qual região ?",
            )
          ),
          SizedBox(height: 12.0,),
          Text("Imagem da tatuagem", style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 12.0),
          Center(
            child: _imageScar == null
              ? Icon(Icons.image, size: 40.0,)
              : Image.file(_imageScar),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("camera"),
                onPressed: getTatooImageCamera,
              ),
              FlatButton(
                child: Text("galeria"),
                onPressed: getTatooImageGallery,
              ),
            ],
          ),
          SizedBox(height: 40.0),
          Text("Informações Adicionais", style: TextStyle(fontSize: 24.0),),
          TextField(
            controller: _extras,
            maxLines: 5,
            decoration: InputDecoration(
              filled: true,
              labelText: "informacoes adicionais",
            )
          ),

          SizedBox(height: 40.0,),
          Text("Informações do Declarante", style: TextStyle(fontSize: 24.0),),
          TextField(
            controller: _nameDeclarant,
            decoration: InputDecoration(
              filled: true,
              labelText: "nome do declarante",
            )
          ),
          SizedBox(height: 12.0,),
          TextField(
            controller: _phoneDeclarant,
            decoration: InputDecoration(
              filled: true,
              labelText: "telefone do declarante",
            )
          ),

          //Envio de Formulário
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("cancelar"),
                onPressed: (){
                  cancel();
                },
              ),
              RaisedButton(
                child: Text("enviar informação"),
                onPressed: () async {
                  Map data = await sendInfo();
                  if(data["sucess"]){
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text("success"),
                        content: Text(data["message"]),
                      )
                    );
                  }
                  else{
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text("failed"),
                        content: Text(data["message"]),
                      )
                    );
                  }
                },
              ),
            ],
          ),

        ]
      ),
    );
  }

  //Funções Auxiliares
  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }
  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  Future getScarImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageScar = image;
    });
  }
  Future getScarImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageScar = image;
    });
  }
  Future getTatooImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageTatoo = image;
    });
  }
  Future getTatooImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageTatoo = image;
    });
  }

  void cancel() {
    setState(() {
      _name.clear();
      _cpf.clear();
      _address.clear();
      _phone.clear();
      _lastContact.clear();
    });
  }
  Future<Map> sendInfo() async {
    _post = {
      "name": _name.text,
      "cpf": _cpf.text,
      "address": _address.text,
      "phone": _phone.text,
      "lastContact": _lastContact.text,
      "physicalCharacteristics": _physicalCharacteristics.text,
      "tatoo": _tatoo.text,
      "scar": _scar.text,
      "extras": _extras.text,
      "nameDeclarent": _nameDeclarant.text,
      "phoneDeclarant": _phoneDeclarant,
      "image": _image,
      "imageScar": _imageScar,
      "imageTatoo": _imageTatoo
    };
    Map response = await addPeopleInfo(_post);
    return response;
  }
}