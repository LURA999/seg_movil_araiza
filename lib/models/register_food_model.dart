class RegisterFood {
  String? numEmployee;
  String? name;
  String? contract;

  RegisterFood({
    this.numEmployee,
    this.name,
    this.contract,
  });

  RegisterFood.fromJson(Map<String, dynamic> json){
    numEmployee = json['numEmployee'];
    name = json['name'];
    contract= json['contract'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['numEmployee'] = numEmployee;
    data['name'] = name;
    data['contract'] = contract;
    return data;
  }

}