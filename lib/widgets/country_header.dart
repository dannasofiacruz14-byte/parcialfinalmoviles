import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CountryHeader extends StatelessWidget {
  const CountryHeader({
    super.key,
    required this.country,
    required this.flag,
    required this.updated,
  });

  final String country;
  final String flag;
  final String updated;

  Widget _placeholder() {
    return Container(
      width: 64,
      height: 44,
      color: AppColors.line,
      child: const Icon(Icons.flag_rounded, color: AppColors.primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: flag.isEmpty
              ? _placeholder()
              : Image.network(
                  flag,
                  width: 64,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _placeholder(),
                ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                country,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Actualizado: $updated',
                style: const TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}