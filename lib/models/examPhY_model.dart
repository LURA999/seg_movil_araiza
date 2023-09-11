
class ExamPhYModel {
  int? idEyes;
  int? near_30cm;
  String? od_rosenbaun;
  String? oi_rosenbaun;
  String? od_jaeguer;
  String? oi_jaeguer;
  int? far_glasses;
  String? od_snellen;
  String? oi_snellen;
  String? od_campimetry;
  String? oi_campimetry;
  String? color_campimetry;
  int? amsler_normal;
  int? fk_idExploration;

    ExamPhYModel({ 
      this.idEyes,
      this.near_30cm,
      this.od_rosenbaun,
      this.oi_rosenbaun,
      this.od_jaeguer,
      this.oi_jaeguer,
      this.far_glasses,
      this.od_snellen,
      this.oi_snellen,
      this.od_campimetry,
      this.oi_campimetry,
      this.color_campimetry,
      this.amsler_normal,
      this.fk_idExploration
    });


    ExamPhYModel.fromJson(Map<String, dynamic> json){ 
      idEyes = json['idEyes'];
      near_30cm = json['near_30cm'];
      od_rosenbaun = json['od_rosenbaun'];
      oi_rosenbaun = json['oi_rosenbaun'];
      od_jaeguer = json['od_jaeguer'];
      oi_jaeguer = json['oi_jaeguer'];
      far_glasses = json['far_glasses'];
      od_snellen = json['od_snellen'];
      oi_snellen = json['oi_snellen'];
      od_campimetry = json['od_campimetry'];
      oi_campimetry = json['oi_campimetry'];
      color_campimetry = json['color_campimetry'];
      amsler_normal = json['amsler_normal'];
      fk_idExploration = json['fk_idExploration'];

    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idEyes'] = idEyes ?? '';
      data['near_30cm'] = near_30cm ?? '';
      data['od_rosenbaun'] = od_rosenbaun ?? '';
      data['oi_rosenbaun'] = oi_rosenbaun ?? '';
      data['od_jaeguer'] = od_jaeguer ?? '';
      data['oi_jaeguer'] = oi_jaeguer ?? '';
      data['far_glasses'] = far_glasses ?? '';
      data['od_snellen'] = od_snellen ?? '';
      data['oi_snellen'] = oi_snellen ?? '';
      data['od_campimetry'] = od_campimetry ?? '';
      data['oi_campimetry'] = oi_campimetry ?? '';
      data['color_campimetry'] = color_campimetry ?? '';
      data['amsler_normal'] = amsler_normal ?? '';
      data['fk_idExploration'] = fk_idExploration ?? '';
      return data;
    }
}