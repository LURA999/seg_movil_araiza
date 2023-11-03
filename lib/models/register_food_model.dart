class RegisterFood {
  String? numEmployee;
  String? name;
  String? contract;
  String? local;

  RegisterFood({
    this.numEmployee,
    this.name,
    this.contract,
    this.local
  });

  RegisterFood.fromJson(Map<String, dynamic> json){
    numEmployee = json['numEmployee'];
    name = json['name'];
    contract= json['contract'];
    local= json['local'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['numEmployee'] = numEmployee;
    data['name'] = name;
    data['contract'] = contract;
    data['local'] = local;
    return data;
  }

}