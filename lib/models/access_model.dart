class Access {
  String? info;
  int? status;
  dynamic container;
  // List<Map<String, dynamic>>? arrContainer;

  Access({
    this.info,
    this.status,
    this.container
  });

  Access.fromJson(Map<String, dynamic> json){
    info = json['info'];
    status = int.parse(json['status']);
    container = json['container'];

  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['info'] = info;
    data['status'] = status;
    data['container'] = container;
    return data;
  }
}