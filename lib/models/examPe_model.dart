
class ExamPeModel {
  int? idPersonal;
  String? name;
  String? address;
  String? place_birthday;
  String? date_birthday;
  String? schooling;
  String? college_career;
  int? sex;
  String? age;
  String? marital_status;
  String? tel_cel;
  String? extra_activity;
  String? number_children;

    ExamPeModel({ 
      this.idPersonal,
      this.name,
      this.address,
      this.place_birthday,
      this.date_birthday,
      this.schooling,
      this.college_career,
      this.sex,
      this.age,
      this.marital_status,
      this.tel_cel,
      this.extra_activity,
      this.number_children,
    });


    ExamPeModel.fromJson(Map<String, dynamic> json){ 
      idPersonal = json['idPersonal'];
      name = json['name'];
      address = json['address'];
      place_birthday = json['place_birthday'];
      date_birthday = json['date_birthday'];
      schooling = json['schooling'];
      college_career = json['college_career'];
      sex = json['sex'];
      age = json['age'];
      marital_status = json['marital_status'];
      tel_cel = json['tel_cel'];
      extra_activity = json['extra_activity'];
      number_children = json['number_children'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['name'] = name ?? '';
      data['address'] = address ?? '';
      data['place_birthday'] = place_birthday ?? '';
      data['date_birthday'] = date_birthday ?? '';
      data['schooling'] = schooling ?? '';
      data['college_career'] = college_career ?? '';
      data['sex'] = sex ?? '';
      data['age'] = age ?? '';
      data['marital_status'] = marital_status ?? '';
      data['tel_cel'] = tel_cel ?? '';
      data['extra_activity'] = extra_activity ?? '';
      data['number_children'] = number_children ?? '';
      return data;
    }
}