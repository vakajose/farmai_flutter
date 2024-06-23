import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/dto/Parcela.dart';
import 'dart:math';

class ParcelaMapsView extends StatefulWidget {
  const ParcelaMapsView({super.key});

  @override
  State<ParcelaMapsView> createState() => _ParcelaMapsViewState();
}

class _ParcelaMapsViewState extends State<ParcelaMapsView> {
  late Parcela _parcela;
  late String user_id;
  bool _isLoading = true;
  List<LatLng> parcelaCoordinates = [
    LatLng(-17.66446874030909, -62.6648270500189),
    LatLng(-17.665197267022634, -62.67213832878201),
    LatLng(-17.67025133986496, -62.671564895153466),
    LatLng(-17.669204111210135, -62.66449254706916),
    LatLng(-17.687643549985097, -62.66272446004763),
    LatLng(-17.687780131362857, -62.660096222583746),
    LatLng(-17.66419554203054, -62.66229438482692),
    LatLng(-17.66446874030909, -62.6648270500189)
  ];
  late int area;
  late String location;
  late String crop;
  final List<String> locations = ['Cotoca', 'Santa Cruz', 'San Julian', 'Pailas'];
  final List<String> crops = ['Maíz', 'Trigo', 'Soja', 'Girasol'];

  void _generateRandomValues() {
    final random = Random();
    area = random.nextInt(491) + 10; // 10-500
    location = locations[random.nextInt(locations.length)];
    crop = crops[random.nextInt(crops.length)];
  }

  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    _parcela = args?['parcela'] as Parcela;
    if (_parcela != null && _isLoading) {
       parcelaCoordinates = convertirUbicacionALatLng(_parcela.ubicacion);
      _isLoading = false;
    }
  }

  List<LatLng> convertirUbicacionALatLng(List<Ubicacion>? ubicacion) {
    if (ubicacion == null) {
      return [];
    }
   return ubicacion.map((u) => LatLng(u.latitude!, u.longitude!)).toList();
  }

  // Manejador del tipo de mapa
  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final parcelaPolygon = Polygon(
      polygonId: PolygonId('parcela'),
      points: parcelaCoordinates,
      strokeColor: Colors.green,
      fillColor: Colors.green.withOpacity(0.2),
      strokeWidth: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Información de Parcela'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildMap(parcelaPolygon),
            SizedBox(height: 16.0),
            _buildMapTypeSelector(),
            SizedBox(height: 16.0),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildMap(Polygon parcelaPolygon) {
    return Container(
      height: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green, width: 2.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(parcelaPolygon.points.first.latitude,
                           parcelaPolygon.points.first.longitude),
            zoom: 15.0,
          ),
          polygons: {parcelaPolygon},
          mapType: _currentMapType, // Usar el tipo de mapa seleccionado
          onMapCreated: (GoogleMapController controller) {
            Future.delayed(Duration(milliseconds: 300), () {
              _setMapFitToPolygon(controller, parcelaPolygon);
            });
          },
        ),
      ),
    );
  }

  Widget _buildMapTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Tipo de Mapa: ", style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<MapType>(
          value: _currentMapType,
          items: [
            DropdownMenuItem(
              value: MapType.normal,
              child: Text("Mapa"),
            ),
            DropdownMenuItem(
              value: MapType.satellite,
              child: Text("Satélite"),
            ),
            DropdownMenuItem(
              value: MapType.hybrid,
              child: Text("Híbrido"),
            ),
            DropdownMenuItem(
              value: MapType.terrain,
              child: Text("Terreno"),
            ),
          ],
          onChanged: (MapType? newValue) {
            setState(() {
              _currentMapType = newValue ?? MapType.normal;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Detalles',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 8.0),
          Text('Área: 500 Hectáreas'),
          Text('Ubicación: Cotoca'),
          Text('Cultivo: Maíz'),
        ],
      ),
    );
  }

  void _setMapFitToPolygon(GoogleMapController controller, Polygon polygon) {
    var bounds = _calculateBounds(polygon);
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _calculateBounds(Polygon polygon) {
    double south = polygon.points.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
    double north = polygon.points.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
    double west = polygon.points.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
    double east = polygon.points.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);
    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }
}