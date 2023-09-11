
class ExamHeFModel {
    int? father;
    int? mother;
    int? sibling;
    int? partner;
    int? children;
    int? idHeredityFam;
    int? fk_idExam;

    ExamHeFModel({ 
      this.idHeredityFam,
      this.father,
      this.mother,
      this.sibling,
      this.partner,
      this.children,
      this.fk_idExam
    });


    ExamHeFModel.fromJson(Map<String, dynamic> json){ 
      idHeredityFam = json['idHeredityFam'];
      father = json['father'];
      mother = json['mother'];
      sibling = json['sibling'];
      partner = json['partner'];
      children = json['children'];
      fk_idExam = json['fk_idExam'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idHeredityFam'] = idHeredityFam ?? '';
      data['father'] = father ?? '';
      data['mother'] = mother ?? '';
      data['sibling'] = sibling ?? '';
      data['partner'] = partner ?? '';
      data['children'] = children ?? '';
      data['fk_idExam'] = fk_idExam ?? '';
      return data;
    }
}