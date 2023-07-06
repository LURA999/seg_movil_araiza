class RegisterVehicle {
  String? plates;
  String? typevh;
  String? color;
  String? employeeName;
  String? departament;
  String? timeExit;
  String? timeEnter;

  RegisterVehicle({
    this.plates,
    this.typevh,
    this.color,
    this.employeeName,
    this.departament,
    this.timeExit,
    this.timeEnter
  });

  RegisterVehicle.fromJson(Map<String, dynamic> json){
    plates = json['plates'];
    typevh = json['typevh'];
    color = json['color'];
    employeeName = json['employeeName'];
    departament = json['departament'];
    timeExit = json['timeExit'];
    timeEnter = json['timeEnter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = {};
    data['plates'] = plates!;
    data['typevh'] = typevh!;
    data['color'] = color!;
    data['employeeName'] = employeeName!;
    data['departament'] = departament!;
    if(timeExit != null && timeEnter != null){
      data['timeExit'] = timeExit!;
      data['timeEnter'] = timeEnter!;
    }
    return data;
  }

}