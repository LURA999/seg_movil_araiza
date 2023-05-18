class Register {
  String? plates;
  String? typevh;
  String? color;
  String? employeeName;

  Register({
    this.plates,
    this.typevh,
    this.color,
    this.employeeName
  });

  Register.fromJson(Map<String, dynamic> json){
    plates = json['plates'];
    typevh = json['typevh'];
    color = json['color'];
    employeeName = json['employeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['plates'] = plates;
    data['typevh'] = typevh;
    data['color'] = color;
    data['employeeName'] = employeeName;
    return data;
  }

}