
class ExamApModel {
  String? sense;
  String? digestive;
  String? respiratory;
  String? circulatory;
  String? genitourinary;
  String? muscle_skeletal;
  String? nervous;
  int? idAparattusSystem;

    ExamApModel({
      this.idAparattusSystem, 
      this.sense,
      this.digestive,
      this.respiratory,
      this.circulatory,
      this.genitourinary,
      this.muscle_skeletal,
      this.nervous
    });


    ExamApModel.fromJson(Map<String, dynamic> json){ 
      idAparattusSystem = json['idAparattusSystem'];
      sense = json['sense'];
      digestive = json['digestive'];
      respiratory = json['respiratory'];
      circulatory = json['circulatory'];
      genitourinary = json['genitourinary'];
      muscle_skeletal = json['muscle_skeletal'];
      nervous = json['nervous'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idAparattusSystem'] = idAparattusSystem ?? '';
      data['sense'] = sense ?? '';
      data['digestive'] = digestive ?? '';
      data['respiratory'] = respiratory ?? '';
      data['circulatory'] = circulatory ?? '';
      data['genitourinary'] = genitourinary ?? '';
      data['muscle_skeletal'] = muscle_skeletal ?? '';
      data['nervous'] = nervous ?? '';
      return data;
    }
}