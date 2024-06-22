import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EvaluacionView extends StatelessWidget {
  const EvaluacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de Análisis', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[700]!, Colors.green[100]!],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSectionTitle('Imágenes', context),
                const SizedBox(height: 10),
                _buildCarousel(),
                const SizedBox(height: 20),
                _buildSectionTitle('Detalles', context),
                const SizedBox(height: 10),
                _buildInfoCard(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    final List<String> _carouselImages = [
      'https://via.placeholder.com/800x400.png?text=Image+1',
      'https://via.placeholder.com/800x400.png?text=Image+2',
      'https://via.placeholder.com/800x400.png?text=Image+3',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
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

  Widget _buildInfoCard() {
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
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
          child: Column(
            children: [
              Markdown(
                data: _markdownData,
                shrinkWrap: true,
                styleSheet: MarkdownStyleSheet(
                  h1: TextStyle(fontSize: 20, color: Colors.green[800], fontWeight: FontWeight.bold),
                  h2: TextStyle(fontSize: 18, color: Colors.green[700], fontWeight: FontWeight.bold),
                  p: TextStyle(fontSize: 16, color: Colors.green[800]),
                  listBullet: TextStyle(color: Colors.green[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
