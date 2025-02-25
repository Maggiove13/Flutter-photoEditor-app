import 'dart:io';
import 'package:flutter/material.dart';
import '../filters/filters.dart'; // Los filtros
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

class EditScreen extends StatefulWidget {
  final File imagePath;

  const EditScreen({super.key, required this.imagePath});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _globalKey = GlobalKey();
  ColorFilter? _selectedFilter;

  void applyFilter(ColorFilter? filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  // Guardar imagen editada en la galería
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

      Directory directory = await getTemporaryDirectory();
      String filePath = '${directory.path}/edited_image.png';

      File file = File(filePath);
      await file.writeAsBytes(pngBytes);

      bool? success = await GallerySaver.saveImage(filePath);
      if (success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Imagen guardada en la galería 📸")),
        );
      } else {
        throw Exception("No se pudo guardar en la galería");
      }
    } catch (e) {
      print("Error al guardar la imagen: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al guardar la imagen ❌")),
      );
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
                colorFilter:
                    _selectedFilter ??
                    const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.multiply,
                    ),
                child: Image.file(widget.imagePath),
              ),
            ),
          ),
          // Lista de filtros como miniaturas
          Container(
            height: 80, // Tamaño del contenedor de los filtros
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterThumbnail("Normal", null),
                _buildFilterThumbnail("B/N", ColorFilters.greyscale),
                _buildFilterThumbnail("Sepia", ColorFilters.sepia),
                _buildFilterThumbnail("Invertir", ColorFilters.invert),
              ],
            ),
          ),
          // Botón de Guardar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: _saveEditedImage,
              icon: const Icon(Icons.save),
              label: const Text("Guardar"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Miniatura de cada filtro
  Widget _buildFilterThumbnail(String label, ColorFilter? filter) {
    return GestureDetector(
      onTap: () => applyFilter(filter),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    _selectedFilter == filter
                        ? Colors.blue
                        : Colors.transparent,
                width: 2,
              ),
            ),
            child: ColorFiltered(
              colorFilter:
                  filter ??
                  const ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.multiply,
                  ),
              child: Image.file(widget.imagePath, fit: BoxFit.cover),
            ),
          ),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
