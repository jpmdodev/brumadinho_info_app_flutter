import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
final String urlAddPeopleInfo = "http://localhost/addPeopleInfo.php";

Future<Map> addPeopleInfo(Map<String, dynamic> post) async {
  http.Response resposta = await http.post(urlAddPeopleInfo, headers: {"Content-type": "multipart/form-data"}, body: post);
  if(resposta.statusCode == 200){
    return jsonDecode(resposta.body);
  }
  else{
    return {"sucesso": false, "mensagem": "Comunicação falhou.", "dados": []};
  }
}