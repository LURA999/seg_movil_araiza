
class ExamImModel {
   int? idImagingStudy;
   String? thorax_radiograph;
   String? rx_lumbar_spine;
   int? spirometry;
   int? audiometry;
   int? covid_test;
   int? pregnancy;
   int? antidoping;

    ExamImModel({ 
      this.idImagingStudy,
      this.thorax_radiograph,
      this.rx_lumbar_spine,
      this.spirometry,
      this.audiometry,
      this.covid_test,
      this.pregnancy,
      this.antidoping,
    });


    ExamImModel.fromJson(Map<String, dynamic> json){ 
      idImagingStudy = json['idImagingStudy'];
      thorax_radiograph = json['thorax_radiograph'];
      rx_lumbar_spine = json['rx_lumbar_spine'];
      spirometry = json['spirometry'];
      audiometry = json['audiometry'];
      covid_test = json['covid_test'];
      pregnancy = json['pregnancy'];
      antidoping = json['antidoping'];
    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idImagingStudy'] = idImagingStudy ?? '';
      data['thorax_radiograph'] = thorax_radiograph ?? '';
      data['rx_lumbar_spine'] = rx_lumbar_spine ?? '';
      data['spirometry'] = spirometry ?? '';
      data['audiometry'] = audiometry ?? '';
      data['covid_test'] = covid_test ?? '';
      data['pregnancy'] = pregnancy ?? '';
      data['antidoping'] = antidoping ?? '';
      return data;
    }
}