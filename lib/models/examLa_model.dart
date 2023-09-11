
class ExamLaModel {
   String? result;
   String? drug;
   int? idLaboratoryTest;

    ExamLaModel({ 
      this.result, 
      this.drug,
      this.idLaboratoryTest
    });


    ExamLaModel.fromJson(Map<String, dynamic> json){ 
      result = json['result'];
      drug = json['drug'];
      idLaboratoryTest = json['idLaboratoryTest'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['result'] = result ?? '';
       data['drug'] = drug ?? '';
       data['idLaboratoryTest'] = idLaboratoryTest ?? '';
      return data;
    }
}