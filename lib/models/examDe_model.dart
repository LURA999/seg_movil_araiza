
class ExamDeModel {
  String? datetime_modification;
  int? fk_InitOrPre;
  int? fk_personalLife;
  int? fk_heredetyBack;
  int? fk_heredityPers;
  int? fk_patalogicalPersBack;
  int? fk_apparatusSystem;
  int? fk_physicalExploration;
  int? fk_laboratoryTest;
  int? fk_imagingStudy;
  String? suitable;
  String? not_suitable;
  String? suitable_more;
  String? condition_observation;
  String? applicant_signature;
  String? doctor_signature;
  int? idDetExamInPr;
  String? local;

    ExamDeModel({ 
      this.idDetExamInPr,
      this.datetime_modification,
      this.fk_InitOrPre,
      this.fk_personalLife,
      this.fk_heredetyBack,
      this.fk_heredityPers,
      this.fk_patalogicalPersBack,
      this.fk_apparatusSystem,
      this.fk_physicalExploration,
      this.fk_laboratoryTest,
      this.fk_imagingStudy,
      this.suitable,
      this.not_suitable,
      this.suitable_more,
      this.condition_observation,
      this.applicant_signature,
      this.doctor_signature,
      this.local
    });


    ExamDeModel.fromJson(Map<String, dynamic> json){ 
      idDetExamInPr = json['idDetExamInPr'];
      datetime_modification = json['datetime_modification'];
      fk_InitOrPre = json['fk_InitOrPre'];
      fk_personalLife = json['fk_personalLife'];
      fk_heredetyBack = json['fk_heredetyBack'];
      fk_heredityPers = json['fk_heredityPers'];
      fk_patalogicalPersBack = json['fk_patalogicalPersBack'];
      fk_apparatusSystem = json['fk_apparatusSystem'];
      fk_physicalExploration = json['fk_physicalExploration'];
      fk_laboratoryTest = json['fk_laboratoryTest'];
      fk_imagingStudy = json['fk_imagingStudy'];
      suitable = json['suitable'];
      not_suitable = json['not_suitable'];
      suitable_more = json['suitable_more'];
      condition_observation = json['condition_observation'];
      applicant_signature = json['applicant_signature'];
      doctor_signature = json['doctor_signature'];
      local = json['local'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idDetExamInPr'] = idDetExamInPr ?? '';
      data['datetime_modification'] = datetime_modification ?? '';
      data['fk_InitOrPre'] = fk_InitOrPre ?? '';
      data['fk_personalLife'] = fk_personalLife ?? '';
      data['fk_heredetyBack'] = fk_heredetyBack ?? '';
      data['fk_heredityPers'] = fk_heredityPers ?? '';
      data['fk_patalogicalPersBack'] = fk_patalogicalPersBack ?? '';
      data['fk_apparatusSystem'] = fk_apparatusSystem ?? '';
      data['fk_physicalExploration'] = fk_physicalExploration ?? '';
      data['fk_laboratoryTest'] = fk_laboratoryTest ?? '';
      data['fk_imagingStudy'] = fk_imagingStudy ?? '';
      data['suitable'] = suitable ?? '';
      data['not_suitable'] = not_suitable ?? '';
      data['suitable_more'] = suitable_more ?? '';
      data['condition_observation'] = condition_observation ?? '';
      data['applicant_signature'] = applicant_signature ?? '';
      data['doctor_signature'] = doctor_signature ?? '';
      data['local'] = local ?? '';
      return data;
    }
}