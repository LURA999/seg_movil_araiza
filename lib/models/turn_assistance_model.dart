class TurnAssistance {
  String? course_name;
  String? schedule;
  String? idTurn;
	String? description;
  String? local;
  TurnAssistance({
    this.course_name,
    this.schedule,
    this.idTurn,
    this.description,
    this.local
  });

  TurnAssistance.fromJson(Map<String, dynamic> json){
    course_name = json['course_name'];
    schedule = json['schedule'];
    idTurn = json['idTurn'] ?? '';
    description = json['description'] ?? '';
    local = json['local'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['course_name'] = course_name;
    data['schedule'] = schedule;
    data['idTurn'] = idTurn ?? '';
    data['description'] = description ?? '';
    data['local'] = local ?? '';
    return data;
  }

}