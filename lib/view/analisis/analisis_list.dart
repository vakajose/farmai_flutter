import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalisisListView extends StatefulWidget {
  AnalisisListView({super.key});

  @override
  State<AnalisisListView> createState() => _AnalisisListView();
}

class _AnalisisListView extends State<AnalisisListView> {
  final List<Analisis> analisis = [
    Analisis('Analisis-005', DateTime(2024, 6, 15), 'TIPOA'),
    Analisis('Analisis-006', DateTime(2024, 7, 15), 'TIPOB'),
    Analisis('Analisis-007', DateTime(2024, 6, 16), 'TIPOA'),
    Analisis('Analisis-008', DateTime(2024, 7, 18), 'TIPOB'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Analisis de Parcela', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[400],
        elevation: 0,
      ),
      body: Container(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      monitoreo.nombre,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800]),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(DateFormat('dd/MM/yyyy').format(monitoreo.fecha), 
                              style: TextStyle(color: Colors.grey[600])),
                        Text('${monitoreo.tipo}',
                            style: TextStyle(color: Colors.grey[600])),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/evaluacion');
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Analisis {
  final String nombre;
  final DateTime fecha;
  final String tipo;

  Analisis(this.nombre, this.fecha, this.tipo);
}
