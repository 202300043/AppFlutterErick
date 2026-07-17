import 'package:flutter/cupertino.dart';

import 'theme.dart';

class TerminosPage extends StatelessWidget {
  const TerminosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Términos", overflow: TextOverflow.ellipsis, maxLines: 1),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Términos y Condiciones",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "1. Esta aplicación es un proyecto educativo.\n\n"
                  "2. Los datos de la cuenta (correo y contraseña) se guardan "
                  "únicamente en este dispositivo y no se comparten con terceros.\n\n"
                  "3. Al aceptar estos términos confirmas que usarás la aplicación "
                  "con fines de aprendizaje.\n\n"
                  "4. El equipo del proyecto no se hace responsable por el uso "
                  "indebido de la aplicación.",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
