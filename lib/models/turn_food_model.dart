import 'dart:convert';

class TurnFood {
  String? plate;
  String? garrison;
  String? dessert;
  String? received;
  String? date_hour;
  String? description;

  TurnFood({
    this.plate,
    this.garrison,
    this.dessert,
    this.received,
    this.date_hour,
    this.description
  });

  TurnFood.fromJson(Map<String, dynamic> json){
    plate = json['plate'];
    garrison = json['garrison'];
    dessert = json['dessert'];
    received = json['received'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['plate'] = plate;
    data['garrison'] = garrison;
    data['dessert'] = dessert;
    data['received'] = received;
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