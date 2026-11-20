import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({
    super.key,
    required this.value,
    required this.countries,
    required this.onChanged,
  });

  /// Valor seleccionado (nombre que entiende la API).
  final String value;

  /// Clave: nombre para la API. Valor: texto que ve la persona.
  final Map<String, String> countries;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primary,
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
          items: countries.entries
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e.key,
                  child: Text(e.value),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}