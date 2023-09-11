
class ExamPhXModel {
    int? idExploration;
    String? t_a;
    String? f_c;
    String? weight;
    String? height;
    String? p_abd;
    String? f_r;
    String? temp;
    String? i_m_c;
    int? general_dln;
    String? attitude;
    String? march;
    String? appearence;
    String? edo_animo;
    int? ear_dln;
    String? ear_d;
    String? ear_i;
    String? cae_d;
    String? cae_i;
    String? eardrum_d;
    String? eardrum_i;
    int? head_dln;
    String? hair;
    String? surface;
    String? shape;
    String? breast_pn;
    int? eye_dln;
    String? reflex;
    String? pupil;
    String? back_eye;
    String? pterigion_d;
    String? pterigion_i;
    int? neuro_dln;
    String? reflex_ot;
    String? romberg;
    String? heel_knee;
    int? mouth_dln;
    String? lip;
    String? breath;
    String? tongue;
    String? pharynx;
    String? amygdala;
    String? tooth;
    String? mucosa;
    int? thorax_dln;
    String? shape_thorax;
    String? diaphragm;
    String? rub_thorax;
    String? puff_thorax;
    String? ventilation_thorax;
    String? rales;
    int? abdomen_dln;
    String? shape_abdomen;
    String? pain;
    String? mass;
    String? hernia_d;
    String? hernia_i;
    int? nose_dln;
    String? septum;
    String? mucosa_d;
    String? mucosa_i;
    String? ventilation_nose;
    int? precordial_area_dln;
    String? often;
    String? rhythm;
    String? tones;
    String? rub_precordial;
    String? puff_precordial;
    int? skin_dln;
    String? scar;
    String? texture;
    String? diaphoresis;
    String? other_injury;
    int? extremity_dln;
    String? articulate_ext_d;
    String? articulate_ext_i;
    String? muscular_ext_d;
    String? muscular_ext_i;
    String? nervous_ext_d;
    String? nervous_ext_i;
    String? articulate_mi_d;
    String? articulate_mi_i;
    String? muscular_mi_d;
    String? mucular_mi_i;
    String? nervous_mi_d;
    String? nervous_mi_i;
    String? str_column;

    ExamPhXModel({ 
      this.idExploration,
      this.t_a,
      this.f_c,
      this.weight,
      this.height,
      this.p_abd,
      this.f_r,
      this.temp,
      this.i_m_c,
      this.general_dln,
      this.attitude,
      this.march,
      this.appearence,
      this.edo_animo,
      this.ear_dln,
      this.ear_d,
      this.ear_i,
      this.cae_d,
      this.cae_i,
      this.eardrum_d,
      this.eardrum_i,
      this.head_dln,
      this.hair,
      this.surface,
      this.shape,
      this.breast_pn,
      this.eye_dln,
      this.reflex,
      this.pupil,
      this.back_eye,
      this.pterigion_d,
      this.pterigion_i,
      this.neuro_dln,
      this.reflex_ot,
      this.romberg,
      this.heel_knee,
      this.mouth_dln,
      this.lip,
      this.breath,
      this.tongue,
      this.pharynx,
      this.amygdala,
      this.tooth,
      this.mucosa,
      this.thorax_dln,
      this.shape_thorax,
      this.diaphragm,
      this.rub_thorax,
      this.puff_thorax,
      this.ventilation_thorax,
      this.rales,
      this.abdomen_dln,
      this.shape_abdomen,
      this.pain,
      this.mass,
      this.hernia_d,
      this.hernia_i,
      this.nose_dln,
      this.septum,
      this.mucosa_d,
      this.mucosa_i,
      this.ventilation_nose,
      this.precordial_area_dln,
      this.often,
      this.rhythm,
      this.tones,
      this.rub_precordial,
      this.puff_precordial,
      this.skin_dln,
      this.scar,
      this.texture,
      this.diaphoresis,
      this.other_injury,
      this.extremity_dln,
      this.articulate_ext_d,
      this.articulate_ext_i,
      this.muscular_ext_d,
      this.muscular_ext_i,
      this.nervous_ext_d,
      this.nervous_ext_i,
      this.articulate_mi_d,
      this.articulate_mi_i,
      this.muscular_mi_d,
      this.mucular_mi_i,
      this.nervous_mi_d,
      this.nervous_mi_i,
      this.str_column
    });


    ExamPhXModel.fromJson(Map<String, dynamic> json){ 
      idExploration = json['idExploration'];
      t_a = json['t_a'];
      f_c = json['f_c'];
      weight = json['weight'];
      height = json['height'];
      p_abd = json['p_abd'];
      f_r = json['f_r'];
      temp = json['temp'];
      i_m_c = json['i_m_c'];
      general_dln = json['general_dln'];
      attitude = json['attitude'];
      march = json['march'];
      appearence = json['appearence'];
      edo_animo = json['edo_animo'];
      ear_dln = json['ear_dln'];
      ear_d = json['ear_d'];
      ear_i = json['ear_i'];
      cae_d = json['cae_d'];
      cae_i = json['cae_i'];
      eardrum_d = json['eardrum_d'];
      eardrum_i = json['eardrum_i'];
      head_dln = json['head_dln'];
      hair = json['hair'];
      surface = json['surface'];
      shape = json['shape'];
      breast_pn = json['breast_pn'];
      eye_dln = json['eye_dln'];
      reflex = json['reflex'];
      pupil = json['pupil'];
      back_eye = json['back_eye'];
      pterigion_d = json['pterigion_d'];
      pterigion_i = json['pterigion_i'];
      neuro_dln = json['neuro_dln'];
      reflex_ot = json['reflex_ot'];
      romberg = json['romberg'];
      heel_knee = json['heel_knee'];
      mouth_dln = json['mouth_dln'];
      lip = json['lip'];
      breath = json['breath'];
      tongue = json['tongue'];
      pharynx = json['pharynx'];
      amygdala = json['amygdala'];
      tooth = json['tooth'];
      mucosa = json['mucosa'];
      thorax_dln = json['thorax_dln'];
      shape_thorax = json['shape_thorax'];
      diaphragm = json['diaphragm'];
      rub_thorax = json['rub_thorax'];
      puff_thorax = json['puff_thorax'];
      ventilation_thorax = json['ventilation_thorax'];
      rales = json['rales'];
      abdomen_dln = json['abdomen_dln'];
      shape_abdomen = json['shape_abdomen'];
      pain = json['pain'];
      mass = json['mass'];
      hernia_d = json['hernia_d'];
      hernia_i = json['hernia_i'];
      nose_dln = json['nose_dln'];
      septum = json['septum'];
      mucosa_d = json['mucosa_d'];
      mucosa_i = json['mucosa_i'];
      ventilation_nose = json['ventilation_nose'];
      precordial_area_dln = json['precordial_area_dln'];
      often = json['often'];
      rhythm = json['rhythm'];
      tones = json['tones'];
      rub_precordial = json['rub_precordial'];
      puff_precordial = json['puff_precordial'];
      skin_dln = json['skin_dln'];
      scar = json['scar'];
      texture = json['texture'];
      diaphoresis = json['diaphoresis'];
      other_injury = json['other_injury'];
      extremity_dln = json['extremity_dln'];
      articulate_ext_d = json['articulate_ext_d'];
      articulate_ext_i = json['articulate_ext_i'];
      muscular_ext_d = json['muscular_ext_d'];
      muscular_ext_i = json['muscular_ext_i'];
      nervous_ext_d = json['nervous_ext_d'];
      nervous_ext_i = json['nervous_ext_i'];
      articulate_mi_d = json['articulate_mi_d'];
      articulate_mi_i = json['articulate_mi_i'];
      muscular_mi_d = json['muscular_mi_d'];
      mucular_mi_i = json['mucular_mi_i'];
      nervous_mi_d = json['nervous_mi_d'];
      nervous_mi_i = json['nervous_mi_i'];
      str_column = json['str_column'];

    }


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};
      data['idExploration'] = idExploration ?? '';
      data['t_a'] = t_a ?? '';
      data['f_c'] = f_c ?? '';
      data['weight'] = weight ?? '';
      data['height'] = height ?? '';
      data['p_abd'] = p_abd ?? '';
      data['f_r'] = f_r ?? '';
      data['temp'] = temp ?? '';
      data['i_m_c'] = i_m_c ?? '';
      data['general_dln'] = general_dln ?? '';
      data['attitude'] = attitude ?? '';
      data['march'] = march ?? '';
      data['appearence'] = appearence ?? '';
      data['edo_animo'] = edo_animo ?? '';
      data['ear_dln'] = ear_dln ?? '';
      data['ear_d'] = ear_d ?? '';
      data['ear_i'] = ear_i ?? '';
      data['cae_d'] = cae_d ?? '';
      data['cae_i'] = cae_i ?? '';
      data['eardrum_d'] = eardrum_d ?? '';
      data['eardrum_i'] = eardrum_i ?? '';
      data['head_dln'] = head_dln ?? '';
      data['hair'] = hair ?? '';
      data['surface'] = surface ?? '';
      data['shape'] = shape ?? '';
      data['breast_pn'] = breast_pn ?? '';
      data['eye_dln'] = eye_dln ?? '';
      data['reflex'] = reflex ?? '';
      data['pupil'] = pupil ?? '';
      data['back_eye'] = back_eye ?? '';
      data['pterigion_d'] = pterigion_d ?? '';
      data['pterigion_i'] = pterigion_i ?? '';
      data['neuro_dln'] = neuro_dln ?? '';
      data['reflex_ot'] = reflex_ot ?? '';
      data['romberg'] = romberg ?? '';
      data['heel_knee'] = heel_knee ?? '';
      data['mouth_dln'] = mouth_dln ?? '';
      data['lip'] = lip ?? '';
      data['breath'] = breath ?? '';
      data['tongue'] = tongue ?? '';
      data['pharynx'] = pharynx ?? '';
      data['amygdala'] = amygdala ?? '';
      data['tooth'] = tooth ?? '';
      data['mucosa'] = mucosa ?? '';
      data['thorax_dln'] = thorax_dln ?? '';
      data['puff_thorax'] = puff_thorax ?? '';
      data['shape_thorax'] = shape_thorax ?? '';
      data['diaphragm'] = diaphragm ?? '';
      data['rub_thorax'] = rub_thorax ?? '';
      data['ventilation_thorax'] = ventilation_thorax ?? '';
      data['rales'] = rales ?? '';
      data['abdomen_dln'] = abdomen_dln ?? '';
      data['shape_abdomen'] = shape_abdomen ?? '';
      data['pain'] = pain ?? '';
      data['mass'] = mass ?? '';
      data['hernia_d'] = hernia_d ?? '';
      data['hernia_i'] = hernia_i ?? '';
      data['nose_dln'] = nose_dln ?? '';
      data['septum'] = septum ?? '';
      data['mucosa_d'] = mucosa_d ?? '';
      data['mucosa_i'] = mucosa_i ?? '';
      data['ventilation_nose'] = ventilation_nose ?? '';
      data['precordial_area_dln'] = precordial_area_dln ?? '';
      data['often'] = often ?? '';
      data['rhythm'] = rhythm ?? '';
      data['tones'] = tones ?? '';
      data['rub_precordial'] = rub_precordial ?? '';
      data['puff_precordial'] = puff_precordial ?? '';
      data['skin_dln'] = skin_dln ?? '';
      data['scar'] = scar ?? '';
      data['texture'] = texture ?? '';
      data['diaphoresis'] = diaphoresis ?? '';
      data['other_injury'] = other_injury ?? '';
      data['extremity_dln'] = extremity_dln ?? '';
      data['articulate_ext_d'] = articulate_ext_d ?? '';
      data['articulate_ext_i'] = articulate_ext_i ?? '';
      data['muscular_ext_d'] = muscular_ext_d ?? '';
      data['muscular_ext_i'] = muscular_ext_i ?? '';
      data['nervous_ext_d'] = nervous_ext_d ?? '';
      data['nervous_ext_i'] = nervous_ext_i ?? '';
      data['articulate_mi_d'] = articulate_mi_d ?? '';
      data['articulate_mi_i'] = articulate_mi_i ?? '';
      data['muscular_mi_d'] = muscular_mi_d ?? '';
      data['mucular_mi_i'] = mucular_mi_i ?? '';
      data['nervous_mi_d'] = nervous_mi_d ?? '';
      data['nervous_mi_i'] = nervous_mi_i ?? '';
      data['str_column'] = str_column ?? '';
      return data;
    }
}