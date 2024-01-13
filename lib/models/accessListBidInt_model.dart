class AccessListBidiInt {
  String? info;
  int? status;
  List<List<int>>? container; // Declaración de la propiedad container como List<int>?

  AccessListBidiInt({
    this.info,
    this.status,
    this.container,
  });


  factory AccessListBidiInt.fromJson(Map<String, dynamic> json) {
    // Asegúrate de que json['container'] sea realmente una lista dinámica.
    final containerData = json['container'] as List<dynamic>?;
    
    List<List<int>> backBid (List<dynamic> json){
      List<List<int>> aux = [];

      for (var i = 0; i < json.length; i++) {
        aux.add((json[i] as List<dynamic>).map((e) => int.parse(e)).toList());
      }
     
      return aux;
    }


    return AccessListBidiInt(
      info: json['info'] as String?,
      status: int.tryParse(json['status'].toString()), // Intenta convertir a int de forma segura.
      container: containerData != null ? backBid(containerData) : [[]],
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
