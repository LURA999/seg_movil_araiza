
class DateExcelVehicle {
   String? dateStart;
   String? dateFinal;
   String? guard;
   String? turn;
   String? local;

    DateExcelVehicle({ 
      this.dateStart, 
      this.dateFinal, 
      this.guard, 
      this.turn,
      this.local
    });


    DateExcelVehicle.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      turn = json['turn'];
      guard = json['guard'];
      local = json['local'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart ?? '';
       data['dateFinal'] = dateFinal ?? '';
       data['turn'] = turn ?? '';
       data['guard'] = guard ?? '';
       data['local'] = local ?? '';
      return data;
    }
}