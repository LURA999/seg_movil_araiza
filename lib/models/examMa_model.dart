
class ExamMaModel {
   int? idExam;
   int? numEmployee;
   int? fk_initial_pre_entry;

    ExamMaModel({ 
      this.numEmployee, 
      this.fk_initial_pre_entry,
      this.idExam, 
    });


    ExamMaModel.fromJson(Map<String, dynamic> json){ 
      idExam = json['idExam'];
      numEmployee = json['numEmployee'];
      fk_initial_pre_entry = json['fk_initial_pre_entry'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idExam'] = idExam ?? '';
      data['numEmployee'] = numEmployee ?? '';
      data['fk_initial_pre_entry'] = fk_initial_pre_entry ?? '';
      return data;
    }
}