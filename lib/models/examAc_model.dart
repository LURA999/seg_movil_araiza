class ExamAcModel {
  String? company;
  String? date;
  String? position;
  int? causa;
  String? disease_name;
  int? incapacity;
  int? number_d_incapacity;
  int? fk_idExam;
  int? idAccidentDisease;
  
    ExamAcModel({ 
      this.idAccidentDisease,
      this.company,
      this.date,
      this.position,
      this.causa,
      this.disease_name,
      this.incapacity,
      this.number_d_incapacity,
      this.fk_idExam
    });


    ExamAcModel.fromJson(Map<String, dynamic> json){ 
      idAccidentDisease = json['idAccidentDisease'];
      company = json['company'];
      date = json['date'];
      position = json['position'];
      causa = json['causa'];
      disease_name = json['disease_name'];
      incapacity = json['incapacity'];
      number_d_incapacity = json['number_d_incapacity'];
      fk_idExam = json['fk_idExam'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idAccidentDisease'] = idAccidentDisease ?? '';
      data['company'] = company ?? '';
      data['date'] = date ?? '';
      data['position'] = position ?? '';
      data['causa'] = causa ?? '';
      data['disease_name'] = disease_name ?? '';
      data['incapacity'] = incapacity ?? '';
      data['number_d_incapacity'] = number_d_incapacity ?? '';
      data['fk_idExam'] = fk_idExam ?? '';
      return data;
    }
}