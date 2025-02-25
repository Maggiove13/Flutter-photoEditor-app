import 'dart:io';
import 'package:flutter/material.dart';
import '../filters/filters.dart'; // Importa los filtros

class EditScreen extends StatefulWidget {
  final File imagePath;

  const EditScreen({super.key, required this.imagePath});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  ColorFilter? _selectedFilter;

  void applyFilter(ColorFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Imagen")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ColorFiltered(
                colorFilter:
                    _selectedFilter ??
                    const ColorFilter.mode(Colors.transparent, BlendMode.dst),
                child: Image.file(widget.imagePath),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => applyFilter(ColorFilters.greyscale),
                child: const Text("Blanco y Negro"),
              ),
              ElevatedButton(
                onPressed: () => applyFilter(ColorFilters.sepia),
                child: const Text("Sepia"),
              ),
              ElevatedButton(
                onPressed: () => applyFilter(ColorFilters.invert),
                child: const Text("Invertir"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
