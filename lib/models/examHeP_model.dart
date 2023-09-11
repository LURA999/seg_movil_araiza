
class ExamHePModel {
  int? fk_dominant_hand;
  int? smoking;
  String? age_smoking;
  String? amount_cigarettes;
  int? alcohol;
  String? age_alcohol;
  String? often_alcohol;
  int? taxonomists;
  String? age_taxonomists;
  String? often_taxonomists;
  int? allergy_medicament;
  String? what_medicament;
  int? allergy_food;
  String? what_food;
  int? covid_vaccine;
  int? tetanus_vaccine;
  int? hepatitis_vaccine;
  int? pneumococcal_vaccine;
  String? other_vaccine;
  int? practice_exercise;
  String? what_exercise;
  String? often_exercise;
  int? idHeredityPers;

    ExamHePModel({
      this.idHeredityPers,
      this.fk_dominant_hand,
      this.smoking,
      this.age_smoking,
      this.amount_cigarettes,
      this.alcohol,
      this.age_alcohol,
      this.often_alcohol,
      this.taxonomists,
      this.age_taxonomists,
      this.often_taxonomists,
      this.allergy_medicament,
      this.what_medicament,
      this.allergy_food,
      this.what_food,
      this.covid_vaccine,
      this.tetanus_vaccine,
      this.hepatitis_vaccine,
      this.pneumococcal_vaccine,
      this.other_vaccine,
      this.practice_exercise,
      this.what_exercise,
      this.often_exercise
    });


    ExamHePModel.fromJson(Map<String, dynamic> json){ 
      idHeredityPers = json['idHeredityPers'];
      fk_dominant_hand = json['fk_dominant_hand'];
      smoking = json['smoking'];
      age_smoking = json['age_smoking'];
      amount_cigarettes = json['amount_cigarettes'];
      alcohol = json['alcohol'];
      age_alcohol = json['age_alcohol'];
      often_alcohol = json['often_alcohol'];
      taxonomists = json['taxonomists'];
      age_taxonomists = json['age_taxonomists'];
      often_taxonomists = json['often_taxonomists'];
      allergy_medicament = json['allergy_medicament'];
      what_medicament = json['what_medicament'];
      allergy_food = json['allergy_food'];
      what_food = json['what_food'];
      covid_vaccine = json['covid_vaccine'];
      tetanus_vaccine = json['tetanus_vaccine'];
      hepatitis_vaccine = json['hepatitis_vaccine'];
      pneumococcal_vaccine = json['pneumococcal_vaccine'];
      other_vaccine = json['other_vaccine'];
      practice_exercise = json['practice_exercise'];
      what_exercise = json['what_exercise'];
      often_exercise = json['often_exercise'];
      fk_dominant_hand = json['fk_dominant_hand'];
      smoking = json['smoking'];
      age_smoking = json['age_smoking'];
      amount_cigarettes = json['amount_cigarettes'];
      alcohol = json['alcohol'];
      age_alcohol = json['age_alcohol'];
      often_alcohol = json['often_alcohol'];
      taxonomists = json['taxonomists'];
      age_taxonomists = json['age_taxonomists'];
      often_taxonomists = json['often_taxonomists'];
      allergy_medicament = json['allergy_medicament'];
      what_medicament = json['what_medicament'];
      allergy_food = json['allergy_food'];
      what_food = json['what_food'];
      covid_vaccine = json['covid_vaccine'];
      tetanus_vaccine = json['tetanus_vaccine'];
      hepatitis_vaccine = json['hepatitis_vaccine'];
      pneumococcal_vaccine = json['pneumococcal_vaccine'];
      other_vaccine = json['other_vaccine'];
      practice_exercise = json['practice_exercise'];
      what_exercise = json['what_exercise'];
      often_exercise = json['often_exercise'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idHeredityPers'] = idHeredityPers ?? '';
      data['fk_dominant_hand'] = fk_dominant_hand ?? ''; 
      data['smoking'] = smoking ?? '';
      data['age_smoking'] = age_smoking ?? '';
      data['amount_cigarettes'] = amount_cigarettes ?? '';
      data['alcohol'] = alcohol ?? '';
      data['age_alcohol'] = age_alcohol ?? '';
      data['often_alcohol'] = often_alcohol ?? '';
      data['taxonomists'] = taxonomists ?? '';
      data['age_taxonomists'] = age_taxonomists ?? '';
      data['often_taxonomists'] = often_taxonomists ?? '';
      data['allergy_medicament'] = allergy_medicament ?? '';
      data['what_medicament'] = what_medicament ?? '';
      data['allergy_food'] = allergy_food ?? '';
      data['what_food'] = what_food ?? '';
      data['covid_vaccine'] = covid_vaccine ?? '';
      data['tetanus_vaccine'] = tetanus_vaccine ?? '';
      data['hepatitis_vaccine'] = hepatitis_vaccine ?? '';
      data['pneumococcal_vaccine'] = pneumococcal_vaccine ?? '';
      data['other_vaccine'] = other_vaccine ?? '';
      data['practice_exercise'] = practice_exercise ?? '';
      data['what_exercise'] = what_exercise ?? '';
      data['often_exercise'] = often_exercise ?? '';
      return data;
    }
}