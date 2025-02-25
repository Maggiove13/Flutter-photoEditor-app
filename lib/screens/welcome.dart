import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Navegar a la pantalla de edición y pasar la imagen seleccionada
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditScreen(imagePath: _selectedImage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido a tu editor de fotos'),
            ElevatedButton.icon(
              icon: Icon(
                Icons.camera_alt,
                color: Theme.of(context).colorScheme.surface,
              ),
              label: const Text("Tomar Foto"),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(
                Icons.image,
                color: Theme.of(context).colorScheme.surface,
              ),
              label: const Text("Elegir de la Galería"),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
