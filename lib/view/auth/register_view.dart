import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
   RegisterView({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50), // Espacio en la parte superior
                const FlutterLogo(size: 100),
                const SizedBox(height: 20),
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Regístrate para comenzar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                   // _login(context, emailController.text, passwordController.text)
                  },
                  child: const Text(
                    'Regístrate',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Ya tienes cuenta?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/login");
                      },
                      child: const Text('Inicia Sesión'),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* Future<void> _login(BuildContext context, String email, String password) async {
    AuthBll authBll = AuthBll();
    if(email.isEmpty || password.isEmpty){
      final snackBar = SnackBar(content: Text('Por favor, ingrese su correo y contraseña'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    try {
      var token = await authBll.login(email, password);
      print('Token: $token');
      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushNamed("/");
      }else{
        final snackBar = SnackBar(content: Text('Credenciales inválidas'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  } */
}