import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> evento;
  final bool registrado;
  final VoidCallback onPressed;

  const EventCard({
    super.key,
    required this.evento,
    required this.onPressed,
    this.registrado = false,
  });

  @override
  Widget build(BuildContext context) {
    final categoria = evento['categoria'] as String;
    final color = AppTheme.colorCategoria(categoria);
    final cupo = evento['cupo'] as int;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen con la etiqueta de categoría encima
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  evento['imagen'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 40),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(AppTheme.iconoCategoria(categoria),
                            size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          categoria,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contenido
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento['titulo'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icono: Icons.calendar_today_rounded,
                    texto: '${evento['fecha']} · ${evento['hora']}',
                  ),
                  const SizedBox(height: 4),
                  _InfoRow(
                    icono: Icons.place_rounded,
                    texto: evento['lugar'],
                  ),
                  const SizedBox(height: 4),
                  _InfoRow(
                    icono: Icons.people_alt_rounded,
                    texto: '$cupo lugares disponibles',
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: registrado
                        ? FilledButton.icon(
                            onPressed: onPressed,
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF2E9E5B),
                            ),
                            icon: const Icon(Icons.check_circle, size: 18),
                            label: const Text('Registrado'),
                          )
                        : OutlinedButton.icon(
                            onPressed: onPressed,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: color,
                              side: BorderSide(color: color),
                            ),
                            icon: const Icon(Icons.favorite_border, size: 18),
                            label: const Text('Me interesa'),
                          ),
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

class _InfoRow extends StatelessWidget {
  final IconData icono;
  final String texto;

  const _InfoRow({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icono, size: 15, color: Colors.black54),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            texto,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
