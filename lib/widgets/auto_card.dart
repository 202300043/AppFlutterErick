import 'package:flutter/cupertino.dart';

import '../models/auto.dart';
import '../theme.dart';

class AutoCard extends StatelessWidget {
  const AutoCard({
    super.key,
    required this.auto,
    required this.onEditar,
    required this.onEliminar,
  });

  final Auto auto;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.car_detailed, color: AppColors.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${auto.marca} ${auto.modelo}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  auto.anio != null
                      ? 'Año ${auto.anio} · ${auto.origen == 'local' ? 'Agregado localmente' : 'Catálogo JDM'}'
                      : (auto.origen == 'local' ? 'Agregado localmente' : 'Catálogo JDM'),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onEditar,
            child: const Icon(CupertinoIcons.pencil, color: AppColors.accent, size: 20),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onEliminar,
            child: const Icon(CupertinoIcons.delete, color: AppColors.danger, size: 20),
          ),
        ],
      ),
    );
  }
}
