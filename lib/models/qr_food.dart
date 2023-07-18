class QrFood {
  String? numEmployee;
  String? contract;
  String? name;

QrFood({
    this.numEmployee,
    this.contract,
    this.name,
  });


Map<String, String> toJson() {
    final Map<String, String> data = {};
      data['numEmployee'] = numEmployee.toString();
      data['contract'] = contract.toString();
      data['name'] = name.toString();
    return data;
  } 
  
  factory QrFood.fromJson(Map<String, dynamic> json){
    return QrFood(
      numEmployee: json['numEmployee'] as String,
      contract: json['contract'] as String,
      name: json['name'] as String,
      
    );
  }
} 