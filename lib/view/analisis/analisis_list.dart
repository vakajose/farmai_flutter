import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:myapp/bll/ParcelaBll.dart';
import 'package:myapp/dto/Analisis.dart';

class AnalisisListView extends StatefulWidget {
  AnalisisListView({super.key});

  @override
  State<AnalisisListView> createState() => _AnalisisListView();
}

class _AnalisisListView extends State<AnalisisListView> {
  List<Analisis> analisis = [];
  late String parcela;
  late String user_id;
  bool _isLoading = false; // Estado de carga
  bool _hasLoaded = false; // Estado para evitar múltiples cargas

  List<String> _items = ['Plagas','Sequias'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    parcela = args?['parcela'] as String? ?? '';
    user_id = args?['user_id'] as String? ?? '';

    if (parcela.isNotEmpty && user_id.isNotEmpty && !_hasLoaded) {
      _loadAnalisisByParcela(parcela, user_id);
    }
  }

  Future<void> _loadAnalisisByParcela(String parcela, String user_id) async {
    setState(() {
      _isLoading = true;
    });

    ParcelaBll analisisBll = ParcelaBll();
    try {
      List<Analisis> listAnalisis = await analisisBll.getAnalisisByParcela(user_id, parcela);
      setState(() {
        analisis = listAnalisis;
        _hasLoaded = true; // Marcar que se ha cargado
      });
    } catch (error) {
      print('Error cargando analisis: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Método para mostrar el diálogo de carga
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Evitar que el diálogo se cierre al tocar fuera
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generando Análisis con IA'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Por favor espera...'),
            ],
          ),
        );
      },
    );
  }

  // Método para cerrar el diálogo de carga
  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _analisisType(String userId, String parcelaId, {String type = "plagas"}) async {
    ParcelaBll parcelaBll = ParcelaBll();
    
    // Mostrar el diálogo de carga
    _showLoadingDialog(context);

    try {
      // Llamar al método para obtener análisis con IA
      if(!_isLoading){
        _isLoading = true;
        await parcelaBll.getAnalisisWithIA(userId, parcelaId, type);
        _isLoading = false;
      }
      // Aquí puedes actualizar el estado o manejar la respuesta como necesites
    } catch (error) {
      print('Error al obtener análisis: $error');
    } finally {
      // Cerrar el diálogo de carga
      _hideLoadingDialog(context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analisis de Parcela', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[400],
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[400]!, Colors.green[100]!],
          ),
        ),
        child: ListView.builder(
          itemCount: analisis.length,
          itemBuilder: (context, index) {
            final monitoreo = analisis[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.green[50]!],
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[200],
                      child: Icon(Icons.bookmark, color: Colors.amber[800]),
                    ),
                    title: Text(
                      monitoreo.tipo,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800]),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Próximo monitoreo: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(monitoreo.fecha.isNotEmpty ? monitoreo.fecha : DateTime.now().toString()))}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          '${monitoreo.id}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton.icon(
                      icon: const Icon(Icons.history, size: 18, color: Colors.white,),
                      label: const Text('Analisis', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/evaluacion', arguments: {'analisis': monitoreo});
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.green[600],
        children: [
          SpeedDialChild(
            child: Icon(Icons.compost),
            backgroundColor: Colors.green,
            label: 'Analisis de Plagas',
            onTap: () => {
              _analisisType(user_id, parcela, type: 'plagas')
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.water_drop),
            backgroundColor: Colors.cyan,
            label: 'Analisis de Nutricion',
            onTap: () => {
              _analisisType(user_id, parcela, type: 'nutricion')
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.coronavirus),
            backgroundColor: Colors.orange,
            label: 'Analisis de Maleza',
            onTap: () => {
              _analisisType(user_id, parcela, type: 'maleza')
            },
          ),
        ],
      ),
    );
  }
}
