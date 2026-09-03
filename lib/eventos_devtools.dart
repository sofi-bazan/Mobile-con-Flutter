// eventos_devtools.dart
// ============================================================================
// SECCIÓN: EVENTOS Y DEVTOOLS
// ============================================================================
// Esta sección contiene ejemplos de gestos avanzados y herramientas
// de desarrollo de Flutter:
//   • GestureDetector (onLongPress, onDoubleTap)
//   • Dismissible (deslizar para eliminar)
//   • Draggable + DragTarget (arrastrar y soltar)
//   • Flutter DevTools (Widget Inspector, Performance)
// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// EJEMPLO COMPLETO: GESTOS AVANZADOS
// ============================================================================
// Este ejemplo combina:
//   • Dismissible: deslizar un ítem para eliminarlo
//   • GestureDetector: onLongPress (mantener presionado) y onDoubleTap
//   • Draggable + DragTarget: arrastrar elementos y soltarlos en un destino
// ============================================================================

// ---------------------------------------------------------------------
// Modelo simple: un producto de la lista, con su estado de "favorito"
// ---------------------------------------------------------------------
class Producto {
  Producto(this.nombre, {this.favorito = false});
  final String nombre;
  bool favorito;
}

class HomePageEventos extends StatefulWidget {
  const HomePageEventos({super.key});

  @override
  State<HomePageEventos> createState() => _HomePageEventosState();
}

class _HomePageEventosState extends State<HomePageEventos> {
  final List<Producto> _productos = [
    Producto('Fideos'),
    Producto('Yerba'),
    Producto('Leche'),
    Producto('Manzanas'),
    Producto('Pan'),
  ];

  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos y DevTools'),
        backgroundColor: Colors.deepPurple[700],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tarjeta explicativa
          Card(
            color: Colors.deepPurple[50],
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 Gestos avanzados',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Mantené presionado un ítem → SnackBar\n'
                        '• Doble toque en un ítem → Favorito ❤️\n'
                        '• Deslizá de derecha a izquierda → Eliminar 🗑️\n'
                        '• Arrastrá la fruta al cesto 🍎→🧺',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // -----------------------------------------------------------
          // Lista: cada ítem combina Dismissible + onLongPress/onDoubleTap
          // -----------------------------------------------------------
          const Text(
            '📋 Lista de compras',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._productos.map(
                (producto) => _ProductoTile(
              producto: producto,
              onLongPress: () {
                _mostrarSnackBar('Mantuviste presionado: ${producto.nombre}');
              },
              onDoubleTap: () {
                setState(() => producto.favorito = !producto.favorito);
                _mostrarSnackBar(
                  producto.favorito
                      ? '${producto.nombre} agregado a favoritos ❤️'
                      : '${producto.nombre} removido de favoritos',
                );
              },
              onDismissed: () {
                setState(() => _productos.remove(producto));
                _mostrarSnackBar('${producto.nombre} eliminado 🗑️');
              },
            ),
          ),
          const Divider(height: 32),

          // -----------------------------------------------------------
          // Demo aparte: Draggable + DragTarget
          // -----------------------------------------------------------
          const Text(
            '🔄 Arrastrá y soltá',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Arrastrá la fruta hasta el cesto para contarla',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),
          const _DragDemo(),
          const SizedBox(height: 24),

          // -----------------------------------------------------------
          // Card con información sobre DevTools
          // -----------------------------------------------------------
          Card(
            elevation: 2,
            color: Colors.grey[50],
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🔧 Flutter DevTools',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Widget Inspector: seleccioná "Select widget mode" '
                        'y tocá cualquier elemento para ver su posición en el árbol\n'
                        '• Performance: monitoreá el rendimiento mientras scrolleás '
                        'y tocás ítems\n'
                        '• Console: mirá los mensajes de print() mientras probás',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Un ítem de la lista: Dismissible (deslizar para borrar) envolviendo un
// GestureDetector (mantener presionado / doble toque).
// ---------------------------------------------------------------------
class _ProductoTile extends StatelessWidget {
  const _ProductoTile({
    required this.producto,
    required this.onLongPress,
    required this.onDoubleTap,
    required this.onDismissed,
  });

  final Producto producto;
  final VoidCallback onLongPress;
  final VoidCallback onDoubleTap;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(producto.nombre), // único por ítem: obligatorio
      direction: DismissDirection.endToStart, // solo de derecha a izquierda
      onDismissed: (_) => onDismissed(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        child: Container(
          color: producto.favorito ? Colors.amber[100] : null,
          child: ListTile(
            leading: Icon(
              producto.favorito ? Icons.favorite : Icons.favorite_border,
              color: producto.favorito ? Colors.red : Colors.grey,
            ),
            title: Text(producto.nombre),
            subtitle: const Text(
              'Mantené presionado o doble toque para probar',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Demo de Draggable + DragTarget: arrastrar un ícono hasta un "cesto"
// ---------------------------------------------------------------------
class _DragDemo extends StatefulWidget {
  const _DragDemo();

  @override
  State<_DragDemo> createState() => _DragDemoState();
}

class _DragDemoState extends State<_DragDemo> {
  int _recibidas = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Elemento arrastrable: una manzana 🍎
        Draggable<String>(
          data: 'manzana',
          feedback: const Icon(Icons.apple, size: 48, color: Colors.red),
          childWhenDragging: const Opacity(
            opacity: 0.3,
            child: Icon(Icons.apple, size: 48, color: Colors.red),
          ),
          child: const Icon(Icons.apple, size: 48, color: Colors.red),
        ),

        // Destino donde se puede soltar la manzana
        DragTarget<String>(
          onAccept: (data) {
            setState(() => _recibidas++);
          },
          builder: (context, candidateData, rejectedData) {
            final activo = candidateData.isNotEmpty;
            return Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: activo ? Colors.teal[100] : Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                'Cesto\n($_recibidas)',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================================
// PANTALLA PRINCIPAL DE LA SECCIÓN EVENTOS Y DEVTOOLS
// ============================================================================
// Esta es la pantalla que se muestra cuando tocás el botón
// "Eventos y DevTools" en el main.
// ============================================================================

class EventosDevToolsScreen extends StatelessWidget {
  const EventosDevToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageEventos();
  }
}