import 'dart:io';
import 'package:flutter/material.dart';
import '../filters/filters.dart'; // Importa los filtros
import 'dart:typed_data';
import 'dart:ui' as ui; // Import necesario
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class EditScreen extends StatefulWidget {
  final File imagePath;

  const EditScreen({super.key, required this.imagePath});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _globalKey = GlobalKey(); // Para capturar la imagen
  ColorFilter _selectedFilter = ColorFilters.greyscale; //  Filtro por defecto

  void applyFilter(ColorFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  //Función para guardar la imagen editada
  Future<void> _saveEditedImage() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Obtener el directorio correcto en dispositivos móviles
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/edited_image.png';

      File file = File(filePath);
      await file.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Imagen guardada en: $filePath")));
    } catch (e) {
      print("Error al guardar la imagen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Imagen")),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: ColorFiltered(
                colorFilter: _selectedFilter,
                child: Image.file(widget.imagePath),
              ), //Imagen original con filtro
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => applyFilter(ColorFilters.greyscale),
                child: const Text("B/N"),
              ),
              ElevatedButton(
                onPressed: () => applyFilter(ColorFilters.sepia),
                child: const Text("Sepia"),
              ),
              ElevatedButton(
                onPressed: () => applyFilter(ColorFilters.invert),
                child: const Text("Invertir"),
              ),
              ElevatedButton(
                onPressed: _saveEditedImage,
                child: const Text("Guardar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
