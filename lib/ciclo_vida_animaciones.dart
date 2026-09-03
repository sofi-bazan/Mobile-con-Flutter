// main.dart
//
// Ejemplo completo y resuelto de la actividad guiada: ciclo de vida
// (initState/dispose) + animaciones implícitas (AnimatedContainer,
// AnimatedSwitcher) sobre una tarjeta de producto.
//
// Cómo usarlo:
// 1. Creá un proyecto nuevo (`flutter create ciclo_animaciones_demo`) o
//    reemplazá el contenido de lib/main.dart de tu proyecto por este archivo.
// 2. Corré la app con `flutter run`.
// 3. Tocá el corazón de cualquier tarjeta: el fondo cambia de color con
//    una animación (AnimatedContainer), y mirá cómo el contador de
//    segundos tiene una pequeña transición cada vez que cambia
//    (AnimatedSwitcher).
// 4. Para ver el error de "dispose() mal hecho": comentá la línea
//    `_timer.cancel();` en el dispose() de _ProductoCardState, navegá a
//    otra pantalla y volvé — vas a ver el error en la consola.

import 'dart:async';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Modelo simple: un producto de la lista, con su estado de "favorito"
// ---------------------------------------------------------------------
class Producto {
  Producto(this.nombre, {this.favorito = false});
  final String nombre;
  bool favorito;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Producto> _productos = [
    Producto('Fideos'),
    Producto('Yerba'),
    Producto('Leche'),
    Producto('Manzanas'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de compras')),
      body: ListView(
        children: _productos
            .map((producto) => ProductoCard(producto: producto))
            .toList(),
      ),
    );
  }
}

// =======================================================================
// ProductoCard: acá está todo lo que pide la actividad
// =======================================================================
class ProductoCard extends StatefulWidget {
  const ProductoCard({super.key, required this.producto});

  final Producto producto;

  @override
  State<ProductoCard> createState() => _ProductoCardState();
}

class _ProductoCardState extends State<ProductoCard> {
  // --- Parte 1: ciclo de vida ---------------------------------------
  int _segundosVisible = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    // Arranca apenas la tarjeta aparece por primera vez en pantalla.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _segundosVisible++);
    });
  }

  @override
  void dispose() {
    // Si esta línea faltara, el Timer seguiría corriendo después de que
    // la tarjeta desaparezca, y en algún momento tiraría el error
    // "setState() called after dispose()".
    _timer.cancel();
    super.dispose();
  }

  // --- Parte 2: animaciones implícitas --------------------------------
  void _toggleFavorito() {
    setState(() {
      widget.producto.favorito = !widget.producto.favorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favorito = widget.producto.favorito;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: AnimatedContainer(
        // AnimatedContainer: anima solo con que cambien sus propiedades.
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: favorito ? Colors.amber[100] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: _toggleFavorito,
            child: Icon(
              favorito ? Icons.favorite : Icons.favorite_border,
              color: favorito ? Colors.red : Colors.grey,
            ),
          ),
          title: Text(widget.producto.nombre),
          // AnimatedSwitcher: cada vez que cambia el texto (por la Key
          // distinta), anima una pequeña transición en vez de saltar.
          subtitle: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              'visto hace ${_segundosVisible}s',
              key: ValueKey<int>(_segundosVisible),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
