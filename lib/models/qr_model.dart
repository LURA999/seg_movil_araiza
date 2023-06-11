import 'dart:convert';

class Qr {
  String? plates;
  String? typevh;
  String? color;
  String? employeeName;
  String? department;
  DateTime? timeEntry;
  DateTime? timeExit;
  int? fkTurn;

  Qr({
    this.plates,
    this.typevh,
    this.color,
    this.employeeName,
    this.department,
    this.timeEntry,
    this.timeExit,
    this.fkTurn
  });

  Qr.fromJson(Map<String, dynamic> json){
    plates = json['plates'];
    color = json['color'];
    employeeName = json['employeeName'];
    department = json['department'];
    timeEntry = json['timeEntry'];
    timeExit = json['timeExit'];
    fkTurn = json['fkTurn'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['plates'] = plates;
    data['color'] = color;
    data['employeeName'] = employeeName;
    data['department'] = department;
    data['timeEntry'] = timeEntry;
    data['timeExit'] = timeExit;
    data['fkTurn'] = fkTurn;
    return data;
  }
}