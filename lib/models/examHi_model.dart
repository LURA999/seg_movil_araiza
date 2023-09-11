
class ExamHiModel {
    String? company;
    String? position;
    String? time;
    int? fk_idExam;
    String? idHistory;

    ExamHiModel({ 
      this.company, 
      this.position, 
      this.time, 
      this.fk_idExam,
      this.idHistory
    });


    ExamHiModel.fromJson(Map<String, dynamic> json){ 
      idHistory = json['idHistory'];
      company = json['company'];
      position = json['position'];
      time = json['time'];
      fk_idExam = json['fk_idExam'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idHistory'] = idHistory ?? '';
       data['company'] = company ?? '';
       data['position'] = position ?? '';
       data['time'] = time ?? '';
       data['fk_idExam'] = fk_idExam ?? '';
      return data;
    }
}