class CommentsSeh {
  String? description1;
  String? description2;
  String? comment;
  // List<Map<String, dynamic>>? arrContainer;

  CommentsSeh({
    this.description1,
    this.description2,
    this.comment
  });

  CommentsSeh.fromJson(Map<String, dynamic> json){
    description1 = json['description1'];
    description2 = json['description2'];
    comment = json['comment'];

  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['description1'] = description1;
    data['description2'] = description2;
    data['comment'] = comment;
    return data;
  }
}