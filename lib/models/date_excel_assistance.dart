
class DateExcelAssistance {
   String? dateStart;
   String? dateFinal;
   String? course_name;
   String? local;
   String? idCourse;
   String? personal;

    DateExcelAssistance({ 
      this.dateStart, 
      this.dateFinal, 
      this.course_name, 
      this.local,
      this.personal
    });


    DateExcelAssistance.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      course_name = json['course_name'];
      local = json['local'];
      personal = json['personal'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart ?? '';
       data['dateFinal'] = dateFinal ?? '';
       data['course_name'] = course_name ?? '';
       data['local'] = local ?? '';
       data['personal'] = personal ?? '';
      return data;
    }
}