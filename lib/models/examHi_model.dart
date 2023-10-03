
class ExamHiModel {
    String? company;
    String? position;
    String? time;
    int? fk_idExam;
    String? idHistory;
    String? when_left;
    String? job_rotation;
    String? solvent_chemical;
    String? fume;
    String? vapor;
    String? dust;
    String? noisy;
    String? material_load;

    ExamHiModel({ 
      this.company, 
      this.position, 
      this.time, 
      this.when_left,
      this.job_rotation,
      this.solvent_chemical,
      this.fume,
      this.vapor,
      this.dust,
      this.noisy,
      this.material_load,
      this.fk_idExam,
      this.idHistory
    });


    ExamHiModel.fromJson(Map<String, dynamic> json){ 
      idHistory = json['idHistory'];
      company = json['company'];
      position = json['position'];
      when_left = json['when_left'];
      job_rotation = json['job_rotation'];
      solvent_chemical = json['solvent_chemical'];
      fume = json['fume'];
      vapor = json['vapor'];
      dust = json['dust'];
      noisy = json['noisy'];
      material_load = json['material_load'];
      time = json['time'];
      fk_idExam = json['fk_idExam'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idHistory'] = idHistory ?? '';
       data['company'] = company ?? '';
       data['position'] = position ?? '';
       data['time'] = time ?? '';
       data['fk_idExam'] = fk_idExam ?? '';
       data['when_left'] = when_left ?? '';
       data['job_rotation'] = job_rotation ?? '';
       data['solvent_chemical'] = solvent_chemical ?? '';
       data['fume'] = fume ?? '';
       data['vapor'] = vapor ?? '';
       data['dust'] = dust ?? '';
       data['noisy'] = noisy ?? '';
       data['material_load'] = material_load ?? '';
       
      return data;
    }
}