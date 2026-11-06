import 'package:flutter/material.dart';
import 'package:catalogo_senati/models/componente.dart';

class AddComponentModal extends StatefulWidget {
  final Function(Componente) onAgregar;

  const AddComponentModal({super.key, required this.onAgregar});

  @override
  State<AddComponentModal> createState() => _AddComponentModalState();
}

class _AddComponentModalState extends State<AddComponentModal> {
  // Clave global para validar el formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar el texto ingresado
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _imageController = TextEditingController();

  String _categoriaSeleccionada = 'Hardware'; // Valor por defecto del Dropdown

  final List<String> _categoriasOptions = [
    'Hardware',
    'Procesadores',
    'Almacenamiento',
    'Periféricos'
  ];

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _descripcionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _guardarComponente() {
    // Valida que ningún campo esté vacío
    if (_formKey.currentState!.validate()) {
      // Crea un nuevo objeto Componente
      final nuevoComponente = Componente(
        id: DateTime.now().toString(), // Genera un ID temporal único
        nombre: _nombreController.text,
        categoria: _categoriaSeleccionada,
        precio: double.parse(_precioController.text),
        descripcion: _descripcionController.text,
        imageUrl: _imageController.text,
      );

      // Ejecuta la función callback para pasarlo al HomeScreen
      widget.onAgregar(nuevoComponente);

      // Cierra el modal emergente
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Esto evita que el teclado tape el formulario
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Nuevo Componente',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Campo: Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Componente',
                  prefixIcon: Icon(Icons.computer),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 12),
              
              // Campo: Categoría (Dropdown)
              DropdownButtonFormField<String>(
                value: _categoriaSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: _categoriasOptions.map((String cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _categoriaSeleccionada = newValue!;
                  });
                },
              ),
              const SizedBox(height: 12),
              
              // Campo: Precio (Con validación numérica)
              TextFormField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Precio (S/.)',
                  hintText: 'Ej. 450.00',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (double.tryParse(value) == null) return 'Ingrese un número válido';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Campo: URL de Imagen
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: 'URL de la Imagen',
                  hintText: 'Ej. https://...',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 12),
              
              // Campo: Descripción
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción Técnica',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 24),
              
              // Botón Guardar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _guardarComponente,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Guardar Componente', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}