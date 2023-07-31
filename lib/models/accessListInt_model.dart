class AccessListInt {
  String? info;
  int? status;
  List<int>? container; // Declaración de la propiedad container como List<int>?

  AccessListInt({
    this.info,
    this.status,
    this.container,
  });

  factory AccessListInt.fromJson(Map<String, dynamic> json) {
    // Asegúrate de que json['container'] sea realmente una lista dinámica.
    final containerData = json['container'] as List<dynamic>?;

    return AccessListInt(
      info: json['info'] as String?,
      status: int.tryParse(json['status'].toString()), // Intenta convertir a int de forma segura.
      container: containerData != null ? containerData.map((element) => int.parse(element)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['info'] = info;
    data['status'] = status;
    data['container'] = container;
    return data;
  }
}
