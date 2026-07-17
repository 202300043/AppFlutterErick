import 'package:flutter/cupertino.dart';

import '../models/auto.dart';

Future<Auto?> mostrarFormularioAuto(
  BuildContext context, {
  Auto? autoExistente,
}) {
  final marcaController = TextEditingController(text: autoExistente?.marca ?? '');
  final modeloController = TextEditingController(text: autoExistente?.modelo ?? '');
  final anioController = TextEditingController(
    text: autoExistente?.anio?.toString() ?? '',
  );

  return showCupertinoDialog<Auto?>(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(autoExistente == null ? 'Agregar auto' : 'Editar auto'),
      content: Column(
        children: [
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: marcaController,
            placeholder: 'Marca',
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: modeloController,
            placeholder: 'Modelo',
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: anioController,
            placeholder: 'Año (opcional)',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            final marca = marcaController.text.trim();
            final modelo = modeloController.text.trim();

            if (marca.isEmpty || modelo.isEmpty) {
              Navigator.of(dialogContext).pop();
              return;
            }

            final anio = int.tryParse(anioController.text.trim());
            final base = autoExistente ?? const Auto(marca: '', modelo: '', origen: 'local');

            Navigator.of(dialogContext).pop(
              base.copyWith(marca: marca, modelo: modelo, anio: anio),
            );
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
