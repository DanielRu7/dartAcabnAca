import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final String texto;
  final bool seleccionado;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.texto,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.colorCategoria(texto);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        avatar: Icon(
          AppTheme.iconoCategoria(texto),
          size: 18,
          color: seleccionado ? Colors.white : color,
        ),
        label: Text(texto),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: seleccionado ? Colors.white : Colors.black87,
        ),
        selected: seleccionado,
        selectedColor: color,
        backgroundColor: Colors.white,
        showCheckmark: false,
        side: BorderSide(color: seleccionado ? color : Colors.black12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onSelected: (_) => onTap(),
      ),
    );
  }
}
