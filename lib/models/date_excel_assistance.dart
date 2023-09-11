
class DateExcelAssistance {
   String? dateStart;
   String? dateFinal;
   String? course_name;

    DateExcelAssistance({ 
      this.dateStart, 
      this.dateFinal, 
      this.course_name, 
    });


    DateExcelAssistance.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      course_name = json['course_name'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart ?? '';
       data['dateFinal'] = dateFinal ?? '';
       data['course_name'] = course_name ?? '';
      return data;
    }
}