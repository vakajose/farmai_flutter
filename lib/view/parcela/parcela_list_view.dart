import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/bll/ParcelaBll.dart';
import 'package:myapp/dto/Parcela.dart';
import 'package:intl/intl.dart';


class ParcelaListView extends StatefulWidget {
  ParcelaListView({super.key});

  @override
  State<ParcelaListView> createState() => _ParcelaListViewState();
}

class _ParcelaListViewState extends State<ParcelaListView> {
  late int tipo;
  late String user_id;
  List<Parcela> parcelas = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    tipo = args?['tipo'] as int? ?? 0;
    user_id = args?['user_id'] as String? ?? '';

    // Solo cargar parcelas si user_id no está vacío y si aún no se ha cargado
    if (user_id.isNotEmpty && _isLoading) {
      _loadParcela();
    }
  }

  Future<void> _loadParcela() async {
    ParcelaBll parcelaBll = ParcelaBll();
    try {
      List<Parcela> listParcelas = await parcelaBll.getParcelaByUsuarioId( user_id);
      setState(() {
        parcelas = listParcelas;
        _isLoading = false;
      });
    } catch (error) {
      // Manejar errores de la llamada a la API
      setState(() {
        _isLoading = false;
      });
      // Mostrar mensaje de error, etc.
      print('Error cargando parcelas: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Parcelas', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                            parcela.nombre??'N/A',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                 'Tipo de Monitoreo: ${parcela.tipoMonitoreo!.join(', ')}', // Une los elementos de la lista con comas
                                style: TextStyle(color: Colors.grey[600]),
                              ),

                              Text(
                                'Proximo monitoreo: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(parcela.proximoMonitoreo.isEmpty?parcela.proximoMonitoreo:DateTime.now().toString()))}',
                                style: TextStyle(color: Colors.grey[600])
                              ),
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
                            onPressed: () {
                              if (this.tipo == 1) {
                                _navigateToInfoParcela(parcela);
                              } else {
                                Navigator.of(context).pushNamed('/analisis', arguments:
                                  {
                                    'parcela': parcela.id,
                                    'user_id': user_id,
                                  }
                                );
                              }
                            },
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



  _navigateToInfoParcela(Parcela parcela){
    Navigator.of(context).pushNamed('/mapsParcelas', arguments: {
                                  'parcela': parcela,
                                } );
  }


}

class ParcelaDto {
  final String nombre;
  final String cultivo;
  final double hectareas;
  final VoidCallback onVer;

  ParcelaDto(this.nombre, this.cultivo, this.hectareas, this.onVer);
}
