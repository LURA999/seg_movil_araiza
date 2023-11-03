class QrFood {
  String? numEmployee;
  String? contract;
  String? name;
  String? local;
  String? localApp;

QrFood({
    this.numEmployee,
    this.contract,
    this.name,
    this.local,
    this.localApp
  });


Map<String, String> toJson() {
    final Map<String, String> data = {};
      data['numEmployee'] = numEmployee.toString();
      data['contract'] = contract.toString();
      data['name'] = name.toString();
      data['local'] = local.toString();
      data['localApp'] = localApp.toString();
    return data;
  } 
  
  factory QrFood.fromJson(Map<String, dynamic> json){
    return QrFood(
      numEmployee: json['numEmployee'] as String,
      contract: json['contract'] as String,
      name: json['name'] as String,
      local: json['local'] as String,
      localApp: json['localApp'] as String,
      
    );
  }
} 