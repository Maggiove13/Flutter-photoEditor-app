import 'dart:io';
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
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photo Editor',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a tu editor de fotos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
