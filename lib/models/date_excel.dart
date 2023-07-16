
class DateExcel {
   String? dateStart;
   String? dateFinal;
   String? guard;
   String? turn;

    DateExcel({ 
      this.dateStart, 
      this.dateFinal, 
      this.guard, 
      this.turn 
    });


    DateExcel.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      turn = json['turn'];
      guard = json['guard'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart ?? '';
       data['dateFinal'] = dateFinal ?? '';
       data['turn'] = turn ?? '';
       data['guard'] = guard ?? '';
      return data;
    }
}