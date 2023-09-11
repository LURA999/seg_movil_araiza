
class ExamInModel {
   int? departament;
   String? place;
   int? type;
   int? idDetExamInPr;

    ExamInModel({ 
      this.idDetExamInPr,
      this.departament, 
      this.place, 
      this.type, 
    });

    ExamInModel.fromJson(Map<String, dynamic> json){
      idDetExamInPr = json['idDetExamInPr']; 
      departament = json['departament'];
      place = json['place'];
      type = json['type'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idDetExamInPr'] = idDetExamInPr ?? '';
      data['departament'] = departament ?? '';
      data['place'] = place ?? '';
      data['type'] = type ?? '';
      return data;
    }
}