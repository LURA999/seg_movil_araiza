
import 'dart:convert';

class TurnVehicle {
  String? guard;
  String? turn;
  String? sign;
  String? description;
  String? idTurn;

  TurnVehicle({
    this.guard,
    this.turn,
    this.sign,
    this.description
  });

  TurnVehicle.fromJson(Map<String, dynamic> json){
    guard = json['guard'];
    turn = json['turn'];
    sign = json['sign'];
    description = json['description'];
    idTurn = json['idTurn'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = {};
    if (guard!=null && turn!=null && sign!=null) {
      data['guard'] = guard!;
      data['turn'] = turn!;
      data['sign'] = sign!;
    }
    
    if(description != null){
      data['description'] = description!;
    }

    data['idTurn'] = idTurn ?? '';
    return data;
  }

  Map<String, dynamic> fromJsonReverse(String jsonString) {
    print(jsonString);
    jsonString = jsonString.replaceAll('{', '').replaceAll('}', '');
    
 Map<String, dynamic> objetoJson = { 
  for (var e in jsonString.split(',').map((e) => e.trim())) 
  e.split(':')[0].trim() : e.split(':')[1].trim()};
    return objetoJson;
  }
}