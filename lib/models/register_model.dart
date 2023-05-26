class Register {
  String? plates;
  String? typevh;
  String? color;
  String? employeeName;
  String? departament;

  Register({
    this.plates,
    this.typevh,
    this.color,
    this.employeeName,
    this.departament
  });

  Register.fromJson(Map<String, dynamic> json){
    plates = json['plates'];
    typevh = json['typevh'];
    color = json['color'];
    employeeName = json['employeeName'];
    departament = json['departament'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['plates'] = plates;
    data['typevh'] = typevh;
    data['color'] = color;
    data['employeeName'] = employeeName;
    data['departament'] = departament;
    return data;
  }

}