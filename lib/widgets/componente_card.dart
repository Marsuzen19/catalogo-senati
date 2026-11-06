import 'package:flutter/material.dart';
import 'package:catalogo_senati/models/componente.dart';

class ComponenteCard extends StatelessWidget {
  final Componente componente;

  const ComponenteCard({super.key, required this.componente});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        // Miniatura de la imagen
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            componente.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.image_not_supported, size: 40),
          ),
        ),
        title: Text(
          componente.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            // Tag visual de la categoría
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                componente.categoria,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Precio formateado
            Text(
              'S/. ${componente.precio.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        // Indicador de navegación
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navegación enviando el objeto como argumento
          Navigator.pushNamed(
            context,
            '/details',
            arguments: componente,
          );
        },
      ),
    );
  }
}