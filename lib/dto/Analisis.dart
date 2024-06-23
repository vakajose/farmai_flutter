class Analisis {
  List<Imagenes>? imagenes;
  String? tipo;
  String? fecha;
  Null? evaluacion;
  String? id;

  Analisis({this.imagenes, this.tipo, this.fecha, this.evaluacion, this.id});

  Analisis.fromJson(Map<String, dynamic> json) {
    if (json['imagenes'] != null) {
      imagenes = <Imagenes>[];
      json['imagenes'].forEach((v) {
        imagenes!.add(new Imagenes.fromJson(v));
      });
    }
    tipo = json['tipo'];
    fecha = json['fecha'];
    evaluacion = json['evaluacion'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imagenes != null) {
      data['imagenes'] = this.imagenes!.map((v) => v.toJson()).toList();
    }
    data['tipo'] = this.tipo;
    data['fecha'] = this.fecha;
    data['evaluacion'] = this.evaluacion;
    data['id'] = this.id;
    return data;
  }
}

class Imagenes {
  String? tipo;
  String? ruta;

  Imagenes({this.tipo, this.ruta});

  Imagenes.fromJson(Map<String, dynamic> json) {
    tipo = json['tipo'];
    ruta = json['ruta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipo'] = this.tipo;
    data['ruta'] = this.ruta;
    return data;
  }
}
