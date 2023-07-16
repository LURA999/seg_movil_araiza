

class AccessMap {
  String? info;
  int? status;
  List<Map<String, dynamic>>? container;

  AccessMap({
    this.info,
    this.status,
    this.container
  });

  factory AccessMap.fromJson(Map<String, dynamic> json){
    return AccessMap(
    info: json['info'] as String,
    status : int.parse(json['status']),
    container : (json['container'] as List<dynamic>)
    .map((i) => Map<String, dynamic>.from(i as Map<String,dynamic>))
    .toList()

    );
  }

  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['info'] = info;
    data['status'] = status;
    data['container'] = container;
    return data;
  }
}