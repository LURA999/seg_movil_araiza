import 'dart:convert';

class Turn {
  String? name;
  String? turn;
  String? sign;
  String? description;

  Turn({
    this.name,
    this.turn,
    this.sign,
    this.description
  });

  Turn.fromJson(Map<String, dynamic> json){
    name = json['name'];
    turn = json['turn'];
    sign = json['sign'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['turn'] = turn;
    data['sign'] = sign;
    data['description'] = description;
    return data;
  }

  Map<String, dynamic> fromJsonReverse(String jsonString) {
    jsonString = jsonString.replaceAll('{', '').replaceAll('}', '');
    
 Map<String, dynamic> objetoJson = { 
  for (var e in jsonString.split(',').map((e) => e.trim())) 
  e.split(':')[0].trim() : e.split(':')[1].trim()};
    return objetoJson;
  }
}