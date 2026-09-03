// widgets_scaffold_composicion.dart
// ============================================================================
// SECCIÓN: WIDGETS, SCAFFOLD, COMPOSICIÓN Y LISTAS
// ============================================================================
// Esta sección contiene todos los ejemplos vistos en clase sobre:
//   • AppBar + Scaffold (estructura básica de una pantalla Material)
//   • GestureDetector (detección de gestos del usuario)
//   • Composición con callbacks (patrón hijo-avisa-al-padre)
//   • ListView (listas de elementos)
//   • StatefulWidget vs StatelessWidget
// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// 1. EJEMPLO APPBAR + SCAFFOLD
// ============================================================================
// Muestra la estructura básica de una pantalla Material: appBar, body
// y floatingActionButton, todos como parámetros con nombre de Scaffold.
// ============================================================================

class TutorialHome extends StatelessWidget {
  const TutorialHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo: AppBar + Scaffold'),
        actions: const [
          // IconButton con onPressed: null → deshabilitado (solo visual)
          IconButton(icon: Icon(Icons.search), onPressed: null),
        ],
      ),
      body: const Center(child: Text('Hello, world!')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar',
        onPressed: () {
          // ScaffoldMessenger muestra un SnackBar (mensaje temporal)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tocaste el FloatingActionButton')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================================================
// 2. EJEMPLO GESTURE DETECTOR
// ============================================================================
// GestureDetector no tiene representación visual propia: solo detecta
// gestos del usuario (en este caso, onTap) y ejecuta lo que le indiquemos.
// ============================================================================

class GestosDemo extends StatefulWidget {
  const GestosDemo({super.key});

  @override
  State<GestosDemo> createState() => _GestosDemoState();
}

class _GestosDemoState extends State<GestosDemo> {
  // Contador de toques. StatefulWidget porque este número cambia.
  int _toques = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo: GestureDetector')),
      body: Center(
        // GestureDetector envuelve a Container para detectar toques
        child: GestureDetector(
          onTap: () {
            // print() manda un mensaje a la consola de depuración
            print('Tocaste el contenedor (van ${_toques + 1} veces)');
            // setState le dice a Flutter "redibujame con el nuevo valor"
            setState(() {
              _toques++;
            });
          },
          child: Container(
            height: 80,
            width: 220,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Tocame (van $_toques)',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 3. EJEMPLO SHOPPING LIST (COMPOSICIÓN CON CALLBACKS + LISTVIEW)
// ============================================================================
// El patrón central: un widget hijo (ShoppingListItem) nunca cambia su
// propio estado. Le avisa a su padre (ShoppingListPage) mediante un
// callback, y es el padre quien decide y actualiza el estado real.
// ============================================================================

/// Clase de datos simple: un producto solo tiene nombre.
class Product {
  const Product({required this.name});
  final String name;
}

/// Firma de la función que ShoppingListItem usa para "avisarle"
/// a su padre que el usuario tocó el ítem.
typedef CartChangedCallback = void Function(Product product, bool inCart);

/// Widget HIJO (Stateless): muestra un producto, pero NO decide
/// por sí mismo si entra o sale del carrito. Solo avisa.
class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  // El color cambia según si está en el carrito o no
  Color _getColor(BuildContext context) {
    return inCart ? Colors.black38 : Theme.of(context).colorScheme.primary;
  }

  // El estilo del texto cambia: si está en el carrito, se tacha
  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return const TextStyle(
      color: Colors.black38,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // El ítem no cambia "inCart" por su cuenta: le avisa al padre
        // llamando a la función que el padre le pasó por constructor.
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

/// Widget PADRE (Stateful): es dueño del estado real (el carrito) y
/// decide qué hacer cuando un hijo le avisa que lo tocaron.
class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  // Lista de productos "de muestra". Podés agregar tu apellido acá.
  final List<Product> _products = const [
    Product(name: 'Fideos'),
    Product(name: 'Yerba'),
    Product(name: 'Leche'),
    Product(name: 'Pan'),
  ];

  // Un Set (conjunto) para saber qué productos están en el carrito.
  final _shoppingCart = <Product>{};

  // Esta función maneja el cambio de estado cuando un producto
  // entra o sale del carrito.
  void _handleCartChanged(Product product, bool inCart) {
    // Cualquier cambio de estado que se muestre en pantalla tiene
    // que ir dentro de un setState.
    setState(() {
      if (!inCart) {
        // Si no estaba en el carrito, lo agregamos
        _shoppingCart.add(product);
      } else {
        // Si ya estaba, lo removemos
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        // .map() recorre cada producto y genera un ShoppingListItem;
        // .toList() convierte ese resultado en la lista que pide ListView.
        children: _products.map((product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================================
// 4. PANTALLA PRINCIPAL DE LA SECCIÓN
// ============================================================================
// Esta es la pantalla que se muestra cuando tocás el botón
// "Widgets, Scaffold, Composición y Listas" en el main.
// Contiene botones para acceder a cada uno de los ejemplos.
// ============================================================================

class WidgetsScaffoldComposicionScreen extends StatelessWidget {
  const WidgetsScaffoldComposicionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets, Scaffold, Composición y Listas'),
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
                  '📚 Contenido de la sección\n'
                      'Seleccioná un ejemplo para verlo en acción',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botón 1: AppBar + Scaffold
            _buildMenuItem(
              context,
              icon: Icons.apps,
              title: 'AppBar + Scaffold',
              subtitle: 'Estructura básica de una pantalla Material',
              color: Colors.blue[700]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TutorialHome(),
                  ),
                );
              },
            ),

            // Botón 2: GestureDetector
            _buildMenuItem(
              context,
              icon: Icons.touch_app,
              title: 'GestureDetector',
              subtitle: 'Detección de gestos del usuario (onTap)',
              color: Colors.orange[700]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GestosDemo(),
                  ),
                );
              },
            ),

            // Botón 3: Shopping List (composición)
            _buildMenuItem(
              context,
              icon: Icons.shopping_cart,
              title: 'Shopping List',
              subtitle: 'Composición con callbacks + ListView',
              color: Colors.teal[700]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingListPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Card con resumen de conceptos
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📝 Resumen de conceptos clave:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint('Scaffold: estructura base de pantalla (appBar, body, floatingActionButton)'),
                    _buildBulletPoint('StatelessWidget: widget que no cambia (como TutorialHome)'),
                    _buildBulletPoint('StatefulWidget: widget que puede cambiar (como GestosDemo)'),
                    _buildBulletPoint('setState(): avisa a Flutter que el estado cambió y hay que redibujar'),
                    _buildBulletPoint('GestureDetector: detecta gestos, no tiene UI propia'),
                    _buildBulletPoint('Composición con callbacks: el hijo avisa al padre, el padre decide'),
                    _buildBulletPoint('ListView: muestra una lista de elementos desplazable'),
                  ],
                ),
              ),
            ),
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

  // Widget auxiliar para los puntos de la lista de resumen
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}