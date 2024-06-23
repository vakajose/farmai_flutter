class Parcela {
  String nombre;
  List<Ubicacion> ubicacion;
  List<String> tipoMonitoreo;
  String proximoMonitoreo;
  String id;
  String usuarioId;

  Parcela({
    String? nombre,
    List<Ubicacion>? ubicacion,
    List<String>? tipoMonitoreo,
    String? proximoMonitoreo,
    String? id,
    String? usuarioId
  })  : this.nombre = nombre ?? '',
        this.ubicacion = ubicacion ?? [],
        this.tipoMonitoreo = tipoMonitoreo ?? [],
        this.proximoMonitoreo = proximoMonitoreo ?? '',
        this.id = id ?? '',
        this.usuarioId = usuarioId ?? '';

  Parcela.fromJson(Map<String, dynamic> json)
      : nombre = json['nombre'] ?? '',
        ubicacion = (json['ubicacion'] as List<dynamic>?)
            ?.map((v) => Ubicacion.fromJson(v))
            .toList() ??
            [],
        tipoMonitoreo = (json['tipo_monitoreo'] as List<dynamic>?)
            ?.map((v) => v as String)
            .toList() ??
            [],
        proximoMonitoreo = json['proximo_monitoreo'] ?? '',
        id = json['id'] ?? '',
        usuarioId = json['usuario_id'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['ubicacion'] = this.ubicacion.map((v) => v.toJson()).toList();
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

  Ubicacion.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'] as double?,
        longitude = json['longitude'] as double?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
