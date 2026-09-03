// interfaces_1.dart
// ============================================================================
// SECCIÓN: INTERFACES 1
// ============================================================================
// Esta sección contiene todos los ejemplos vistos en clase sobre
// interfaces en Flutter:
//   • Column (organización vertical)
//   • Row (organización horizontal)
//   • Stack (superposición)
//   • Componentes UI (TextField, ElevatedButton, Image/Icon, Text)
//   • Conectar botón (StatefulWidget + setState)
//   • Navegación entre pantallas
// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// 1. EJEMPLO COLUMN
// ============================================================================
// Column organiza sus "children" uno DEBAJO del otro, en el mismo orden
// en que están escritos en la lista.
// ============================================================================

class EjemploColumnScreen extends StatelessWidget {
  const EjemploColumnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo Column')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.red,
              child: const Text(
                'Elemento 1',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.teal[800],
              child: const Text(
                'Elemento 2',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.teal[300],
              child: const Text(
                'Elemento 3 (un botón)',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 2. EJEMPLO ROW
// ============================================================================
// Row es igual que Column, pero organiza sus "children"
// uno AL LADO del otro en vez de uno debajo del otro.
// ============================================================================

class EjemploRowScreen extends StatelessWidget {
  const EjemploRowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo Row')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Container(height: 120, color: Colors.red),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(height: 120, color: Colors.teal[800]),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(height: 120, color: Colors.teal[300]),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 3. EJEMPLO STACK
// ============================================================================
// Stack superpone sus "children" uno ENCIMA del otro
// (a diferencia de Column y Row, que los acomodan en fila/columna).
// El orden en la lista importa: el último se dibuja arriba de todos.
// ============================================================================

class EjemploStackScreen extends StatelessWidget {
  const EjemploStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo Stack')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 260,
              height: 180,
              color: Colors.grey[300],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: Colors.red,
              child: const Text(
                'Etiqueta',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 4. EJEMPLO COMPONENTES UI
// ============================================================================
// Los 4 componentes vistos en clase, todos juntos:
//   • Text: muestra texto, no se puede editar
//   • TextField: el usuario puede escribir acá adentro
//   • ElevatedButton: dispara una acción al tocarlo
//   • Image/Icon: muestra una imagen o ícono
// ============================================================================

class EjemploComponentesScreen extends StatelessWidget {
  const EjemploComponentesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Componentes UI')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '¿Cómo te llamás?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Escribí tu nombre...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Saludar'),
            ),
            const SizedBox(height: 12),
            const Icon(Icons.image, size: 80, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 5. EJEMPLO CONECTAR BOTÓN
// ============================================================================
// Cómo hacer que un botón actualice un texto en pantalla.
// Este ejemplo usa StatefulWidget porque necesita "recordar" datos que
// cambian con el tiempo (el saludo) y redibujarse cuando cambian.
// ============================================================================

class EjemploConectarBotonScreen extends StatefulWidget {
  const EjemploConectarBotonScreen({super.key});

  @override
  State<EjemploConectarBotonScreen> createState() =>
      _EjemploConectarBotonScreenState();
}

class _EjemploConectarBotonScreenState
    extends State<EjemploConectarBotonScreen> {
  // TextEditingController nos permite leer lo que el usuario escribe
  final TextEditingController _controladorNombre = TextEditingController();
  // Variable que guarda el saludo actual. Empieza vacía.
  String _saludo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conectar botón')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controladorNombre,
              decoration: const InputDecoration(
                hintText: 'Escribí tu nombre...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // setState le avisa a Flutter "algo cambió, redibujá la pantalla"
                setState(() {
                  // Actualizamos _saludo combinando texto fijo con lo escrito
                  _saludo = '¡Hola, ${_controladorNombre.text}!';
                });
              },
              child: const Text('Saludar'),
            ),
            const SizedBox(height: 20),
            // Cada vez que _saludo cambia dentro de un setState,
            // Flutter vuelve a dibujar este texto automáticamente
            Text(_saludo, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 6. EJEMPLO NAVEGACIÓN
// ============================================================================
// Navegar de la Pantalla A a la Pantalla B usando Navigator.push.
// ============================================================================

// Pantalla A: la pantalla inicial, con el botón "Continuar"
class PantallaA extends StatelessWidget {
  const PantallaA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla A')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push le pide a Flutter que agregue una pantalla nueva
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PantallaB()),
            );
          },
          child: const Text('Continuar'),
        ),
      ),
    );
  }
}

// Pantalla B: la pantalla a la que navegamos
class PantallaB extends StatelessWidget {
  const PantallaB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla B')),
      body: const Center(
        child: Text(
          '¡Llegaste a la Pantalla B!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

// ============================================================================
// 7. PANTALLA PRINCIPAL DE LA SECCIÓN INTERFACES 1
// ============================================================================
// Esta es la pantalla que se muestra cuando tocás el botón "Interfaces 1"
// en el main. Contiene botones para acceder a cada uno de los ejemplos.
// ============================================================================

class Interfaces1Screen extends StatelessWidget {
  const Interfaces1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interfaces 1'),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Tarjeta de título
            Card(
              color: Colors.teal[50],
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '📚 Contenido de Interfaces 1\n'
                      'Seleccioná un ejemplo para verlo en acción',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botón 1: Column
            _buildMenuItem(
              context,
              icon: Icons.view_list,
              title: 'Column',
              subtitle: 'Organización vertical de widgets',
              color: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EjemploColumnScreen(),
                  ),
                );
              },
            ),

            // Botón 2: Row
            _buildMenuItem(
              context,
              icon: Icons.view_stream,
              title: 'Row',
              subtitle: 'Organización horizontal de widgets',
              color: Colors.teal[800]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EjemploRowScreen(),
                  ),
                );
              },
            ),

            // Botón 3: Stack
            _buildMenuItem(
              context,
              icon: Icons.layers,
              title: 'Stack',
              subtitle: 'Superposición de widgets',
              color: Colors.grey[600]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EjemploStackScreen(),
                  ),
                );
              },
            ),

            // Botón 4: Componentes UI
            _buildMenuItem(
              context,
              icon: Icons.widgets,
              title: 'Componentes UI',
              subtitle: 'Text, TextField, ElevatedButton, Icon',
              color: Colors.blue[700]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EjemploComponentesScreen(),
                  ),
                );
              },
            ),

            // Botón 5: Conectar botón
            _buildMenuItem(
              context,
              icon: Icons.sync,
              title: 'Conectar botón',
              subtitle: 'StatefulWidget + setState',
              color: Colors.orange[700]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EjemploConectarBotonScreen(),
                  ),
                );
              },
            ),

            // Botón 6: Navegación
            _buildMenuItem(
              context,
              icon: Icons.navigation,
              title: 'Navegación',
              subtitle: 'Navigator.push entre pantallas',
              color: Colors.purple[700]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaA(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir cada elemento del menú
  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}