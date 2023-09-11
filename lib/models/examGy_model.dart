
class ExamGyModel {
  String? idGynecologist;
  String? age_fmenstruation;
  String? age_stSex_life;
  String? amount_pregnancy;
  int? amount_childbirth;
  String? cesarean;
  String? abort;
  String? last_rule_date;
  String? rhythm;
  int? fk_contraceptive_method;
  String? date_last_pap_smear;
  String? result_pap_smear;
  String? mammography_date;
  String? result_mammography;
  String? lactation;
  int? fk_idHeredityPers;

    ExamGyModel({ 
      this.idGynecologist,
      this.age_fmenstruation,
      this.age_stSex_life,
      this.amount_pregnancy,
      this.amount_childbirth,
      this.cesarean,
      this.abort,
      this.last_rule_date,
      this.rhythm,
      this.fk_contraceptive_method,
      this.date_last_pap_smear,
      this.result_pap_smear,
      this.mammography_date,
      this.result_mammography,
      this.lactation,
      this.fk_idHeredityPers 
    });


    ExamGyModel.fromJson(Map<String, dynamic> json){ 
      fk_idHeredityPers  = json['fk_idHeredityPers'];
      idGynecologist = json['idGynecologist'];
      age_fmenstruation = json['age_fmenstruation'];
      age_stSex_life = json['age_stSex_life'];
      amount_pregnancy = json['amount_pregnancy'];
      amount_childbirth = json['amount_childbirth'];
      cesarean = json['cesarean'];
      abort = json['abort'];
      last_rule_date = json['last_rule_date'];
      rhythm = json['rhythm'];
      fk_contraceptive_method = json['fk_contraceptive_method'];
      date_last_pap_smear = json['date_last_pap_smear'];
      result_pap_smear = json['result_pap_smear'];
      mammography_date = json['mammography_date'];
      result_mammography = json['result_mammography'];
      lactation = json['lactation'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['fk_idHeredityPers'] = fk_idHeredityPers  ?? '';
      data['idGynecologist'] = idGynecologist ?? '';
      data['age_fmenstruation'] = age_fmenstruation ?? '';
      data['age_stSex_life'] = age_stSex_life ?? '';
      data['amount_pregnancy'] = amount_pregnancy ?? '';
      data['amount_childbirth'] = amount_childbirth ?? '';
      data['cesarean'] = cesarean ?? '';
      data['abort'] = abort ?? '';
      data['last_rule_date'] = last_rule_date ?? '';
      data['rhythm'] = rhythm ?? '';
      data['fk_contraceptive_method'] = fk_contraceptive_method ?? '';
      data['date_last_pap_smear'] = date_last_pap_smear ?? '';
      data['result_pap_smear'] = result_pap_smear ?? '';
      data['mammography_date'] = mammography_date ?? '';
      data['result_mammography'] = result_mammography ?? '';
      data['lactation'] = lactation ?? '';
      return data;
    }
}