import 'dart:convert';

class Qr {
  String? platesSearch;
  String? typevh;
  String? color;
  String? employeeName;
  String? departament;
  DateTime? timeEntry;
  DateTime? timeExit;
  String? fkTurn;
  String? employee_num;

  Qr({
    this.platesSearch,
    this.typevh,
    this.color,
    this.employeeName,
    this.departament,
    this.timeEntry,
    this.timeExit,
    this.fkTurn,
    this.employee_num
  });

  Qr.fromJson(Map<String, dynamic> json){
    platesSearch = json['platesSearch'] ?? '' ;
    color = json['color'] ?? '';
    employeeName = json['employeeName'] ?? '';
    departament = json['departament'] ?? '';
    fkTurn = json['fkTurn'] ?? '';
    typevh = json['typevh'] ?? '';
    timeEntry = json['timeEntry'] ?? '';
    timeExit = json['timeExit'] ?? '';
    employee_num = json['employee_num'] ?? '';
  }


List<dynamic>  toJsonArr(Map<String, dynamic> arr) {
    // arr["data"].forEach((key, value) {print(value);});
    // print(arr["data"]);
     List<dynamic> jsonArray = jsonDecode(arr["data"]);
    return  jsonArray;
   /*  for (var el in jsonArray) {
      el['platesSearch'] = platesSearch;
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
    data['platesSearch'] = platesSearch?? '';
    data['color'] = color?? '';
    data['employeeName'] = employeeName?? '';
    data['departament'] = departament?? '';
    data['typevh'] = typevh ?? '';
    data['fkTurn'] = fkTurn!.toString();
    data['employee_num'] = employee_num!.toString();

    if(timeEntry != null && timeExit != null){
      data['timeEntry'] = timeEntry!.toString();
      data['timeExit'] = timeExit!.toString();
    }
    return data;
  }
}