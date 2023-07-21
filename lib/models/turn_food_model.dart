class TurnFood {
  String? dish;
  String? garrison;
  String? dessert;
  String? received;
  String? date_hour;
  String? description;
  String? picture;

  TurnFood({
    this.dish,
    this.garrison,
    this.dessert,
    this.received,
    this.date_hour,
    this.picture,
    this.description
  });

  TurnFood.fromJson(Map<String, dynamic> json){
    dish = json['dish'];
    garrison = json['garrison'];
    dessert = json['dessert'];
    received = json['received'];
    description = json['description'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['dish'] = dish;
    data['garrison'] = garrison;
    data['dessert'] = dessert;
    data['received'] = received;
    data['description'] = description;
    data['picture'] = picture;
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