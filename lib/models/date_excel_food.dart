
class DateExcelFood {
   String? dateStart;
   String? dateFinal;
   String? dish;
   String? local;

    DateExcelFood({ 
      this.dateStart, 
      this.dateFinal, 
      this.dish, 
      this.local
    });


    DateExcelFood.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      dish = json['dish'];
      local = json['local'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart ?? '';
       data['dateFinal'] = dateFinal ?? '';
       data['dish'] = dish ?? '';
       data['local'] = local ?? '';
      return data;
    }
}