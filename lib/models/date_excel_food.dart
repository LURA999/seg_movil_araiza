
class DateExcelFood {
   String? dateStart;
   String? dateFinal;
   String? plate;

    DateExcelFood({ 
      this.dateStart, 
      this.dateFinal, 
      this.plate, 
    });


    DateExcelFood.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      plate = json['plate'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart ?? '';
       data['dateFinal'] = dateFinal ?? '';
       data['plate'] = plate ?? '';
      return data;
    }
}