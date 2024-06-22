import 'package:flutter/material.dart';

class ParcelaListView extends StatefulWidget {
  ParcelaListView({super.key});

  @override
  State<ParcelaListView> createState() => _ParcelaListViewState();
}

class _ParcelaListViewState extends State<ParcelaListView> {
  final List<Parcela> parcelas = [
    Parcela('Parcela Amanecer', 'Cultivo de Maíz', 15.5, () => print('Ver Parcela 1')),
    Parcela('Parcela Atardecer', 'Cultivo de Trigo', 20.2, () => print('Ver Parcela 2')),
    Parcela('Parcela Río Verde', 'Cultivo de Soja', 18.7, () => print('Ver Parcela 3')),
    Parcela('Parcela Montaña', 'Cultivo de Papa', 12.3, () => print('Ver Parcela 4')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Parcelas', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[700]!, Colors.green[100]!],
          ),
        ),
        child: ListView.builder(
          itemCount: parcelas.length,
          itemBuilder: (context, index) {
            final parcela = parcelas[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
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
                      child: Icon(Icons.landscape, color: Colors.green[800]),
                    ),
                    title: Text(
                      parcela.nombre,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(parcela.cultivo, style: TextStyle(color: Colors.grey[600])),
                        Text('${parcela.hectareas} hectáreas', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                    trailing: ElevatedButton.icon(
                      icon: Icon(Icons.visibility, size: 18),
                      label: Text('Ver'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onPressed: parcela.onVer,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green[600],
        onPressed: () {
          // Acción para agregar nueva parcela
        },
      ),
    );
  }
}

class Parcela {
  final String nombre;
  final String cultivo;
  final double hectareas;
  final VoidCallback onVer;

  Parcela(this.nombre, this.cultivo, this.hectareas, this.onVer);
}