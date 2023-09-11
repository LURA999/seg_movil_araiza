
class ExamPaModel {
  int? idPatalogicalPersBack;
  int? arthritis;
  int? asthma;
  int? bronchitis;
  int? hepatitis;
  int? covid;
  int? kidney_disease;
  int? skin_disease;
  int? thyreous_disease;
  int? hernia;
  int? low_back_pain;
  int? diabetes;
  int? gastitris;
  int? gynaecological;
  int? hemorrhoid;
  int? ulcer;
  int? varices;
  int? pneumonia;
  int? tuberculosis;
  int? colitis;
  int? depression;
  String? other_disease;
  String? hospitalization;
  String? reason_hospitalization;
  String? surgery;
  String? reason_surgery;
  String? transfusion;
  String? reason_transfusion;
  String? trauma_fracture;
  String? what_trauma_fracture;
  String? complication;
  String? what_complication;
  String? chronic_disease;
  String? what_chronic;
  String? current_treatment;

    ExamPaModel({ 
      this.idPatalogicalPersBack,
      this.arthritis,
      this.asthma,
      this.bronchitis,
      this.hepatitis,
      this.kidney_disease,
      this.skin_disease,
      this.thyreous_disease,
      this.hernia,
      this.low_back_pain,
      this.diabetes,
      this.gastitris,
      this.gynaecological,
      this.hemorrhoid,
      this.ulcer,
      this.varices,
      this.pneumonia,
      this.tuberculosis,
      this.colitis,
      this.depression,
      this.other_disease,
      this.hospitalization,
      this.reason_hospitalization,
      this.surgery,
      this.reason_surgery,
      this.transfusion,
      this.reason_transfusion,
      this.trauma_fracture,
      this.what_trauma_fracture,
      this.complication,
      this.what_complication,
      this.chronic_disease,
      this.what_chronic,
      this.current_treatment
    });


    ExamPaModel.fromJson(Map<String, dynamic> json){ 
      idPatalogicalPersBack = json['idPatalogicalPersBack'];
      arthritis = json['arthritis'];
      asthma = json['asthma'];
      bronchitis = json['bronchitis'];
      hepatitis = json['hepatitis'];
      kidney_disease = json['kidney_disease'];
      skin_disease = json['skin_disease'];
      thyreous_disease = json['thyreous_disease'];
      hernia = json['hernia'];
      low_back_pain = json['low_back_pain'];
      diabetes = json['diabetes'];
      gastitris = json['gastitris'];
      gynaecological = json['gynaecological'];
      hemorrhoid = json['hemorrhoid'];
      ulcer = json['ulcer'];
      varices = json['varices'];
      pneumonia = json['pneumonia'];
      tuberculosis = json['tuberculosis'];
      colitis = json['colitis'];
      depression = json['depression'];
      other_disease = json['other_disease'];
      hospitalization = json['hospitalization'];
      reason_hospitalization = json['reason_hospitalization'];
      surgery = json['surgery'];
      reason_surgery = json['reason_surgery'];
      transfusion = json['transfusion'];
      reason_transfusion = json['reason_transfusion'];
      trauma_fracture = json['trauma_fracture'];
      what_trauma_fracture = json['what_trauma_fracture'];
      complication = json['complication'];
      what_complication = json['what_complication'];
      chronic_disease = json['chronic_disease'];
      what_chronic = json['what_chronic'];
      current_treatment = json['current_treatment'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idPatalogicalPersBack'] = idPatalogicalPersBack ?? '';
      data['arthritis'] = arthritis ?? '';
      data['asthma'] = asthma ?? '';
      data['bronchitis'] = bronchitis ?? '';
      data['hepatitis'] = hepatitis ?? '';
      data['kidney_disease'] = kidney_disease ?? '';
      data['skin_disease'] = skin_disease ?? '';
      data['thyreous_disease'] = thyreous_disease ?? '';
      data['hernia'] = hernia ?? '';
      data['low_back_pain'] = low_back_pain ?? '';
      data['diabetes'] = diabetes ?? '';
      data['gastitris'] = gastitris ?? '';
      data['gynaecological'] = gynaecological ?? '';
      data['hemorrhoid'] = hemorrhoid ?? '';
      data['ulcer'] = ulcer ?? '';
      data['varices'] = varices ?? '';
      data['pneumonia'] = pneumonia ?? '';
      data['tuberculosis'] = tuberculosis ?? '';
      data['colitis'] = colitis ?? '';
      data['depression'] = depression ?? '';
      data['other_disease'] = other_disease ?? '';
      data['hospitalization'] = hospitalization ?? '';
      data['reason_hospitalization'] = reason_hospitalization ?? '';
      data['surgery'] = surgery ?? '';
      data['reason_surgery'] = reason_surgery ?? '';
      data['transfusion'] = transfusion ?? '';
      data['reason_transfusion'] = reason_transfusion ?? '';
      data['trauma_fracture'] = trauma_fracture ?? '';
      data['what_trauma_fracture'] = what_trauma_fracture ?? '';
      data['complication'] = complication ?? '';
      data['what_complication'] = what_complication ?? '';
      data['chronic_disease'] = chronic_disease ?? '';
      data['what_chronic'] = what_chronic ?? '';
      data['current_treatment'] = current_treatment ?? '';
      return data;
    }
}