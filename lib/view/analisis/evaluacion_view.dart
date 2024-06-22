import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EvaluacionView extends StatefulWidget {
  const EvaluacionView({super.key});

  @override
  State<EvaluacionView> createState() => _EvaluacionViewState();
}

class _EvaluacionViewState extends State<EvaluacionView> {
  final List<String> _carouselImages = [
    'https://via.placeholder.com/800x400.png?text=Image+1',
    'https://via.placeholder.com/800x400.png?text=Image+2',
    'https://via.placeholder.com/800x400.png?text=Image+3',
  ];

  final String _markdownData = '''
# Análisis NDVI: Campo de Maíz

## Datos del campo
- Cultivo: Maíz
- Área total: 50 hectáreas

## Resultados NDVI
- Rango: 0.2 - 0.8
- Promedio: 0.6

## Distribución
| Rango NDVI | Porcentaje del campo | Interpretación           |
|------------|----------------------|--------------------------|
| 0.2 - 0.4  | 20%                  | Vegetación estresada     |
| 0.5 - 0.7  | 60%                  | Vegetación saludable     |
| 0.7 - 0.8  | 20%                  | Vegetación muy vigorosa  |

## Interpretación
- Mayoría del cultivo en buenas condiciones
- Área significativa con posible estrés hídrico o deficiencia nutricional
- Zonas identificadas de alto rendimiento potencial

## Acción recomendada
Investigar y tratar las áreas de bajo NDVI, ajustando riego o fertilización en zonas específicas.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informe de Análisis', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: _buildBody(),
    );
  }

  

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(title, style: TextStyle(color: Colors.green[800])),
      onTap: onTap,
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green[700]!, Colors.green[100]!],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildCarousel(),
              const SizedBox(height: 20),
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: _carouselImages.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.green[50]!],
          ),
        ),
        child: Text(
          'Análisis de Parcela - Tipo A',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.green[50]!],
          ),
        ),
        child: Markdown(
          data: _markdownData,
          styleSheet: MarkdownStyleSheet(
            h1: TextStyle(fontSize: 20, color: Colors.green[800], fontWeight: FontWeight.bold),
            h2: TextStyle(fontSize: 18, color: Colors.green[700], fontWeight: FontWeight.bold),
            p: TextStyle(fontSize: 16, color: Colors.green[800]),
            listBullet: TextStyle(color: Colors.green[800]),
          ),
        ),
      ),
    );
  }
}
