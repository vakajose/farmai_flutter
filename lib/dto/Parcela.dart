class Parcela {
  String? nombre;
  List<Ubicacion>? ubicacion;
  List<String>? tipoMonitoreo;
  String? proximoMonitoreo;
  String? id;
  String? usuarioId;

  Parcela(
      {this.nombre,
      this.ubicacion,
      this.tipoMonitoreo,
      this.proximoMonitoreo,
      this.id,
      this.usuarioId});

  Parcela.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    if (json['ubicacion'] != null) {
      ubicacion = <Ubicacion>[];
      json['ubicacion'].forEach((v) {
        ubicacion!.add(new Ubicacion.fromJson(v));
      });
    }
    tipoMonitoreo = json['tipo_monitoreo'].cast<String>();
    proximoMonitoreo = json['proximo_monitoreo'];
    id = json['id'];
    usuarioId = json['usuario_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    if (this.ubicacion != null) {
      data['ubicacion'] = this.ubicacion!.map((v) => v.toJson()).toList();
    }
    data['tipo_monitoreo'] = this.tipoMonitoreo;
    data['proximo_monitoreo'] = this.proximoMonitoreo;
    data['id'] = this.id;
    data['usuario_id'] = this.usuarioId;
    return data;
  }
}

class Ubicacion {
  double? latitude;
  double? longitude;

  Ubicacion({this.latitude, this.longitude});

  Ubicacion.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
