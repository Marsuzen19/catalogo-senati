import 'package:flutter/material.dart';
import 'package:catalogo_senati/models/componente.dart';
import 'package:catalogo_senati/data/mock_data.dart';
import 'package:catalogo_senati/widgets/componente_card.dart';
import 'package:catalogo_senati/widgets/add_component_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Estado de nuestra pantalla
  List<Componente> listaCompleta = [];
  List<Componente> listaMostrada = [];
  String categoriaSeleccionada = 'Todos';

  final List<String> categorias = [
    'Todos',
    'Hardware',
    'Procesadores',
    'Almacenamiento',
    'Periféricos'
  ];

  @override
  void initState() {
    super.initState();
    // Cargamos los datos de prueba iniciales
    listaCompleta = componentesIniciales;
    listaMostrada = listaCompleta;
  }

  // Método para filtrar la lista
  void filtrarPorCategoria(String categoria) {
    setState(() {
      categoriaSeleccionada = categoria;
      if (categoria == 'Todos') {
        listaMostrada = listaCompleta;
      } else {
        listaMostrada = listaCompleta
            .where((comp) => comp.categoria == categoria)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo SENATI', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Acción de búsqueda futura
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de filtros horizontal
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: categorias.map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cat),
                    selected: categoriaSeleccionada == cat,
                    onSelected: (bool selected) {
                      filtrarPorCategoria(cat);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Lista Dinámica
          Expanded(
            child: ListView.builder(
              itemCount: listaMostrada.length,
              itemBuilder: (context, index) {
                final comp = listaMostrada[index];
                return ComponenteCard(componente: comp);
              },
            ),
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {
            // Invoca el modal emergente (Bottom Sheet)
            showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Permite que el modal crezca y no lo tape el teclado
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
                return AddComponentModal(
                onAgregar: (nuevoComponente) {
                    // Lógica reactiva para inyectar el nuevo dato
                    setState(() {
                    listaCompleta.add(nuevoComponente);
                    // Volvemos a aplicar el filtro actual para que aparezca en pantalla
                    filtrarPorCategoria(categoriaSeleccionada);
                    });
                },
                );
            },
            );
        },
        child: const Icon(Icons.add),
        ),
    );
  }
}