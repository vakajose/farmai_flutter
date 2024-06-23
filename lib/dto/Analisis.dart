class Analisis {
  List<Imagenes> imagenes;
  String tipo;
  String fecha;
  String evaluacion;
  String id;

  Analisis({
    List<Imagenes>? imagenes,
    String? tipo,
    String? fecha,
    String? evaluacion,
    String? id
  })  : this.imagenes = imagenes ?? [],
        this.tipo = tipo ?? '',
        this.fecha = fecha ?? '',
        this.evaluacion = evaluacion ?? '',
        this.id = id ?? '';

  Analisis.fromJson(Map<String, dynamic> json)
      : imagenes = (json['imagenes'] as List<dynamic>?)
      ?.map((v) => Imagenes.fromJson(v))
      .toList() ??
      [],
        tipo = json['tipo'] ?? '',
        fecha = json['fecha'] ?? '',
        evaluacion = json['evaluacion'] ?? '',
        id = json['id'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagenes'] = this.imagenes.map((v) => v.toJson()).toList();
    data['tipo'] = this.tipo;
    data['fecha'] = this.fecha;
    data['evaluacion'] = this.evaluacion;
    data['id'] = this.id;
    return data;
  }
}

class Imagenes {
  String tipo;
  String ruta;

  Imagenes({String? tipo, String? ruta})
      : this.tipo = tipo ?? '',
        this.ruta = ruta ?? '';

  Imagenes.fromJson(Map<String, dynamic> json)
      : tipo = json['tipo'] ?? '',
        ruta = json['ruta'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipo'] = this.tipo;
    data['ruta'] = this.ruta;
    return data;
  }
}
