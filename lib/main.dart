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
          primary: const Color(0xFF191921), // Color principal
          onPrimary: Colors.white, // Texto sobre primary
          secondary: Colors.white, // Color secundario
          onSecondary: const Color(0xFF292D38), // Texto sobre fondo
          surface: const Color(0xFF191921), // fondo Scaffold
          onSurface: const Color(0xFFff4d63), // Texto sobre el scaffold
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
            backgroundColor: const Color(0xFFff4d63),
            foregroundColor: Colors.white, //color del texto del boton
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
