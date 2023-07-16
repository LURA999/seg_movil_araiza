class QrVehicle {
  String? typeVh;
  String? color;
  String? plates;
  String? employeeName;
  String? department;
  String? timeEntry;
  String? timeExit;

QrVehicle({
    this.typeVh,
    this.color,
    this.plates,
    this.employeeName,
    this.department,
    this.timeEntry,
    this.timeExit,
  });


Map<String, String> toJson() {
    final Map<String, String> data = {};
      data['type_vh'] = typeVh.toString();
      data['color'] = color.toString();
      data['plates'] = plates.toString();
      data['employee_name'] = employeeName.toString();
      data['department'] = department.toString();
      data['time_entry'] = timeEntry.toString();
      data['time_exit'] = timeExit.toString();
    return data;
  } 
  
  factory QrVehicle.fromJson(Map<String, dynamic> json){
    return QrVehicle(
      typeVh: json['type_vh'] as String,
      color: json['color'] as String,
      plates: json['plates'] as String,
      employeeName: json['employee_name'] as String,
      department: json['department'] as String,
      timeEntry: json['time_entry'] as String,
      timeExit: json['time_exit'] as String?,
    );
  }
} 