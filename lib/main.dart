// main.dart - Punto de entrada de la aplicación
// Esta es la pantalla principal que contiene los botones para
// navegar a cada sección de la materia.

import 'package:flutter/material.dart';
import 'interfaces_1.dart'; // Sección: Interfaces 1
import 'widgets_scaffold_composicion.dart'; // Sección: Widgets, Scaffold, Composición y Listas
import 'eventos_devtools.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apuntes Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apuntes de Flutter'),
        backgroundColor: Colors.pink[300],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título de la sección
            const Text(
              'Secciones de la materia',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Text(
              'Módulo 1',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // BOTÓN PARA INTERFACES 1
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Interfaces1Screen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Interfaces 1'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                foregroundColor: Colors.pink[300],
              ),
            ),
            const SizedBox(height: 16),

            // BOTÓN PARA WIDGETS, SCAFFOLD, COMPOSICIÓN Y LISTAS
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WidgetsScaffoldComposicionScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Widgets, Scaffold, Composición y Listas'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                foregroundColor: Colors.pink[300],
              ),
            ),

            // EJEMPLO DE PRINT()
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                print('Hola Sofi !!');
              },
              icon: const Icon(Icons.add),
              label: const Text('Ejemplo de print() - Consola'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                foregroundColor: Colors.pink[300],
              ),
            ),

            // BOTÓN PARA EVENTOS Y DEVTOOLS
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventosDevToolsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Eventos y DevTools'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                foregroundColor: Colors.pink[300],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Módulo 2',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),

            // BOTÓN PARA CICLO DE VIDA ANIMACIONES
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventosDevToolsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Ciclo de Vida y Animaciones Implicitas'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                foregroundColor: Colors.pink[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}