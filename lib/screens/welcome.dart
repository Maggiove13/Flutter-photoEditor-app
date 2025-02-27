import 'dart:io'; //permite gestionar archivos
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './pick_image.dart'; // Importamos el helper
import 'edit_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> _pickAndEditImage(ImageSource source) async {
    File? selectedImage = await ImagePickerHelper.pickImage(context, source);

    // Verificar si el widget todavía está montado antes de continuar
    if (!mounted) return;

    if (selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditScreen(imagePath: selectedImage),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Selección cancelada"),
          duration: Duration(seconds: 2),
          behavior:
              SnackBarBehavior
                  .floating, // va estar por encima de los demas widgets
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Editor app',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        //para que los hijos ocupen todo el espacio disponible
        fit: StackFit.expand,
        children: [
          // Imagen de fondo
          Image.asset('images/imagen4.webp', fit: BoxFit.cover),
          // Contenido de la pantalla
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Bienvenido a tu editor de fotos',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontFamily: 'Anton',
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Tomar Foto"),
                  onPressed: () => _pickAndEditImage(ImageSource.camera),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text("Elegir de la Galería"),
                  onPressed: () => _pickAndEditImage(ImageSource.gallery),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
