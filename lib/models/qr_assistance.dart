class QrAssistance {
  String? employee_num;
  //String? time;
  String? idTurn;
		
QrAssistance({
    this.employee_num,
    //this.time,
    this.idTurn
  });


Map<String, String> toJson() {
    final Map<String, String> data = {};
      data['employee_num'] = employee_num.toString();
      //data['time'] = time.toString();
      data['idTurn'] = idTurn.toString();
    return data;
  } 
  
  factory QrAssistance.fromJson(Map<String, dynamic> json){
    return QrAssistance(
      employee_num: json['employee_num'] as String,
      //time: json['time'] as String,
      idTurn: json['idTurn'] as String
    );
  }
} 