import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; //para manipular la representación visual de los widgets.
import 'package:gallery_saver_plus/gallery_saver.dart';
import '../filters/filters.dart';
import 'dart:ui'
    as ui; //proporciona acceso a APIs para como la manipulación de imágenes.
import 'dart:typed_data'; //Para trabajar datos binarios
import 'package:path_provider/path_provider.dart';
import '../widgets/dialogs.dart';

class EditScreen extends StatefulWidget {
  final File imagePath;
  //constructor
  const EditScreen({super.key, required this.imagePath});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey _globalKey = GlobalKey(); // Para capturar la imagen editada
  ColorFilter _selectedFilter = ColorFilters.none; // Filtro por defecto

  // Función para aplicar filtros
  void applyFilter(ColorFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  // Función para guardar la imagen editada en la galería
  void _saveImage(BuildContext context) async {
    if (!mounted) return;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onSurface,
              ),
            ),
          );
        },
      );

      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      // Convertimos el objeto en una imagen
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // Convertimos la imagen a una secuencia de bytes
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      // Extraemos la información binaria en una lista de bytes
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Obtenemos la carpeta donde se guardan los archivos en el cel
      final directory = await getApplicationDocumentsDirectory();

      // Creamos la ruta donde se almacenará la imagen
      final filePath = '${directory.path}/edited_image.png';

      //Se convierte a objeto file para poder escrbir en el
      final file = File(filePath);

      //Escribe los bytes al file
      await file.writeAsBytes(pngBytes); //recibe una lista de bytes

      //Guardamos la imagen en la galería del teléfono.
      final bool? success = await GallerySaver.saveImage(file.path);

      if (!mounted) return;

      //Cierra el mesaje de carga de imagen
      Navigator.of(context).pop();

      if (success == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SuccessDialog(
              message: '¡Tu imagen ha sido guardada en la galería!',
            );
          },
        );
      }
    } catch (e) {
      if (!mounted) return;

      Navigator.of(context, rootNavigator: true).pop();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: 'No se pudo guardar la imagen:\n${e.toString()}',
          );
        },
      );

      print("Error detallado: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Imagen"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: ColorFiltered(
                colorFilter: _selectedFilter,
                child: Image.file(widget.imagePath),
              ),
            ),
          ),
          // Contenedor de filtros centrado
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterButton("Normal", ColorFilters.none),
                _buildFilterButton("B/N", ColorFilters.greyscale),
                _buildFilterButton("Sepia", ColorFilters.sepia),
                _buildFilterButton("Invertir", ColorFilters.invert),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Botón de guardar
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            onPressed: () => _saveImage(context),
            label: const Text("Guardar Imagen"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget para crear los filtros como botones visuales
  Widget _buildFilterButton(String name, ColorFilter filter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => applyFilter(filter),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color:
                      _selectedFilter == filter
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
              ),
              child: ColorFiltered(
                colorFilter: filter,
                child: Image.file(widget.imagePath, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
