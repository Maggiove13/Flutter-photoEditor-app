import 'package:flutter/material.dart';
import 'screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Editor',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light, // Puede ser light o dark
          primary: const Color.fromARGB(255, 22, 17, 54), // Color principal
          onPrimary: Colors.white, // Texto sobre primary
          secondary: Colors.transparent, // Color secundario
          onSecondary: Colors.white, // Texto sobre fondo
          surface: const Color.fromARGB(
            255,
            22,
            17,
            54,
          ), // Color de tarjetas, diálogos
          onSurface: Colors.black, // Texto sobre superficie
          error: Colors.red, // Color de errores
          onError: Colors.white, // Texto sobre error
        ),
        useMaterial3: true,
        // Personalización de los botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: const Color.fromARGB(
              255,
              149,
              158,
              167,
            ), // Color de fondo del botón
            foregroundColor: Colors.white, // Color del texto del botón
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
