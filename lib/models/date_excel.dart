import 'package:intl/intl.dart';

class DateExcel {
   String? dateStart;
   String? dateFinal;
   String? guard;

    DateExcel({ 
      this.dateStart, 
      this.dateFinal, 
      this.guard 
    });


    DateExcel.fromJson(Map<String, dynamic> json){ 
      dateStart = json['dateStart'];
      dateFinal = json['dateFinal'];
      guard = json['guard'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
       data['dateStart'] = dateStart;
       data['dateFinal'] = dateFinal;
       data['guard'] = guard;
      return data;
    }
}