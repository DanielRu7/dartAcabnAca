import 'package:flutter/material.dart';

import '../data/event_data.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chip.dart';
import '../widgets/event_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String categoriaSeleccionada = 'Todos';
  String busqueda = '';

  // Títulos de los eventos en los que el usuario se registró
  final Set<String> registrados = {};

  // Filtra por categoría y por texto de búsqueda
  List<Map<String, dynamic>> get eventosMostrados {
    return eventos.where((e) {
      final coincideCategoria = categoriaSeleccionada == 'Todos' ||
          e['categoria'] == categoriaSeleccionada;
      final coincideBusqueda = busqueda.isEmpty ||
          (e['titulo'] as String).toLowerCase().contains(busqueda.toLowerCase());
      return coincideCategoria && coincideBusqueda;
    }).toList();
  }

  void _alternarRegistro(String titulo) {
    final yaRegistrado = registrados.contains(titulo);

    setState(() {
      if (yaRegistrado) {
        registrados.remove(titulo);
      } else {
        registrados.add(titulo);
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            yaRegistrado
                ? 'Quitaste tu registro de: $titulo'
                : 'Te interesa: $titulo',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final lista = eventosMostrados;

    return Scaffold(
      body: SafeArea(
        child: Center(
          // Limita el ancho en pantallas muy grandes
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(registrados: registrados.length),
                  const SizedBox(height: 14),

                  // Buscador
                  TextField(
                    onChanged: (v) => setState(() => busqueda = v),
                    decoration: InputDecoration(
                      hintText: 'Buscar evento...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Categorías
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categorias.length,
                      itemBuilder: (context, index) {
                        final categoria = categorias[index];
                        return CategoryChip(
                          texto: categoria,
                          seleccionado: categoriaSeleccionada == categoria,
                          onTap: () {
                            setState(() {
                              categoriaSeleccionada = categoria;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Eventos encontrados: ${lista.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: lista.isEmpty
                        ? const _SinResultados()
                        : GridView.builder(
                            padding: const EdgeInsets.only(bottom: 20),
                            itemCount: lista.length,
                            // Las columnas se calculan solas según el ancho
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 340,
                              mainAxisExtent: 390,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                            ),
                            itemBuilder: (context, index) {
                              final evento = lista[index];
                              final titulo = evento['titulo'] as String;

                              return EventCard(
                                evento: evento,
                                registrado: registrados.contains(titulo),
                                onPressed: () => _alternarRegistro(titulo),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int registrados;

  const _Header({required this.registrados});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppTheme.headerGradient,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          const Icon(Icons.event_available_rounded,
              color: Colors.white, size: 40),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campus Eventos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Descubre actividades académicas, culturales y deportivas.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$registrados',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'guardados',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SinResultados extends StatelessWidget {
  const _SinResultados();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 56, color: Colors.black38),
          SizedBox(height: 8),
          Text('No hay eventos con esos filtros'),
        ],
      ),
    );
  }
}
