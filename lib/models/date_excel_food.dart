
class DateExcelFood {
   String? dateStart;
   String? dateFinal;
   String? dish;

    DateExcelFood({ 
      this.dateStart, 
      this.dateFinal, 
      this.dish, 
    });


    DateExcelFood.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      dish = json['dish'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart ?? '';
       data['dateFinal'] = dateFinal ?? '';
       data['dish'] = dish ?? '';
      return data;
    }
}