class DescriptionsSeh {
  String? description1;
  String? description2;
  String? local;
  // List<Map<String, dynamic>>? arrContainer;

  DescriptionsSeh({
    this.description1,
    this.description2,
    this.local
  });

  DescriptionsSeh.fromJson(Map<String, dynamic> json){
    description1 = json['description1'];
    description2 = json['description2'];
    local = json['local'];

  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['description1'] = description1;
    data['description2'] = description2;
    data['local'] = local;
    return data;
  }
}