class QrAssistance {
  String? employee_num;
  //String? time;
  String? idTurn;
  String? local;
		
QrAssistance({
    this.employee_num,
    //this.time,
    this.idTurn,
    this.local
  });


Map<String, String> toJson() {
    final Map<String, String> data = {};
      data['employee_num'] = employee_num.toString();
      //data['time'] = time.toString();
      data['idTurn'] = idTurn.toString();
      data['local'] = local.toString();
    return data;
  } 
  
  factory QrAssistance.fromJson(Map<String, dynamic> json){
    return QrAssistance(
      employee_num: json['employee_num'] as String,
      //time: json['time'] as String,
      idTurn: json['idTurn'] as String,
      local: json['local'] as String
    );
  }
} 