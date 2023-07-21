class RegisterVehicle {
  String? platesSearch;
  String? typevh;
  String? color;
  String? employeeName;
  String? departament;
  String? timeExit;
  String? timeEnter;
  String? turn;
  
  RegisterVehicle({
    this.platesSearch,
    this.typevh,
    this.color,
    this.employeeName,
    this.departament,
    this.timeExit,
    this.timeEnter,
    this.turn
  });

  RegisterVehicle.fromJson(Map<String, dynamic> json){
    platesSearch = json['platesSearch'];
    typevh = json['typevh'];
    color = json['color'];
    employeeName = json['employeeName'];
    departament = json['departament'];
    timeExit = json['timeExit'];
    timeEnter = json['timeEnter'];
    turn = json['turn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = {};
    data['platesSearch'] = platesSearch!;
    data['typevh'] = typevh!;
    data['color'] = color!;
    data['employeeName'] = employeeName!;
    data['departament'] = departament!;
    data['turn'] = turn!;
    if(timeExit != null && timeEnter != null){
      data['timeExit'] = timeExit!;
      data['timeEnter'] = timeEnter!;
    }
    return data;
  }

}