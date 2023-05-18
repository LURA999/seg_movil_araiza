class Report {
  DateTime? startDate;
  DateTime? finalDate;
  String? guard;

  Report({
    this.startDate,
    this.finalDate,
    this.guard,
  });

  Report.fromJson(Map<String, dynamic> json){
    startDate = json['startDate'];
    finalDate = json['finalDate'];
    guard = json['guard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['startDate'] = startDate;
    data['finalDate'] = finalDate;
    data['guard'] = guard;
    return data;
  }
}