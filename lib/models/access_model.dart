class Access {
  String? info;
  int? status;

  Access({
    this.info,
    this.status
  });

  Access.fromJson(Map<String, dynamic> json){
    info = json['message'];
    status = json['status'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['info'] = info;
    data['status'] = status;
    return data;
  }
}