import 'dart:convert';

class Qr {
  String? plates;
  String? typevh;
  String? color;
  String? employeeName;
  String? departament;
  DateTime? timeEntry;
  DateTime? timeExit;
  int? fkTurn;

  Qr({
    this.plates,
    this.typevh,
    this.color,
    this.employeeName,
    this.departament,
    this.timeEntry,
    this.timeExit,
    this.fkTurn
  });

  Qr.fromJson(Map<String, dynamic> json){
    plates = json['plates'];
    color = json['color'];
    employeeName = json['employeeName'];
    departament = json['departament'];
    fkTurn = json['fkTurn'];
    typevh = json['typevh'];
    timeEntry = json['timeEntry'];
    timeExit = json['timeExit'];
  }


List<dynamic>  toJsonArr(Map<String, dynamic> arr) {
    // arr["data"].forEach((key, value) {print(value);});
    // print(arr["data"]);
     List<dynamic> jsonArray = jsonDecode(arr["data"]);
    return  jsonArray;
   /*  for (var el in jsonArray) {
      el['plates'] = plates;
      el['color'] = color;
      el['employeeName'] = employeeName;
      el['department'] = department;
      el['timeEntry'] = timeEntry;
      el['timeExit'] = timeExit;
      el['fkTurn'] = fkTurn;
    }
    
    return jsonArray; */
  }

  Map<String, String> toJson() {
    final Map<String, String> data = {};
    data['plates'] = plates!;
    data['color'] = color!;
    data['employeeName'] = employeeName!;
    data['departament'] = departament!;
    data['typevh'] = typevh!;
    data['fkTurn'] = fkTurn!.toString();

    if(timeEntry != null && timeExit != null){
      data['timeEntry'] = timeEntry!.toString();
      data['timeExit'] = timeExit!.toString();
    }
    return data;
  }
}