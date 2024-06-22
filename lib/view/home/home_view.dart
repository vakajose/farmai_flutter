import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Constant/ConstantService.dart';
import 'package:myapp/util/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String user_id = "";

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    user_id = await SharedPref.getString(ConstanstAplication.USER) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[700]!, Colors.green[100]!],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[700],
            ),
            child: Text(
              'Menú Principal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Inicio', () => Navigator.of(context).pushNamed('/home')),
          _buildDrawerItem(Icons.landscape, 'Gestión de Parcelas', () => Navigator.of(context).pushNamed('/parcela', arguments: {'tipo': 1,'user_id': user_id})),
          _buildDrawerItem(Icons.monitor, 'Monitoreo de Parcelas', () => Navigator.of(context).pushNamed('/parcela', arguments: {'tipo': 2,'user_id': user_id})),
          _buildDrawerItem(Icons.logout, 'Cerrar Sesión', () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false)),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(title, style: TextStyle(color: Colors.green[800])),
      onTap: onTap,
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
      items: [
        'https://via.placeholder.com/800x400.png?text=Image+1',
        'https://via.placeholder.com/800x400.png?text=Image+2',
        'https://via.placeholder.com/800x400.png?text=Image+3',
      ].map((url) {
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
                    offset: Offset(0, 3),
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
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.green[50]!],
          ),
        ),
        child: Text(
          'Bienvenido $user_id a la Página Principal',
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
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.green[50]!],
          ),
        ),
        child: Text(
          'Aquí puedes ver un carrusel de imágenes y navegar usando el Menú.',
          style: TextStyle(fontSize: 16, color: Colors.green[800]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}