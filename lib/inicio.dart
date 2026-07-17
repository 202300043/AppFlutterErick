import 'package:flutter/cupertino.dart';

import 'autos.dart';
import 'historial.dart';
import 'main.dart';
import 'theme.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  static const List<double> _gradosPreestablecidos = [
    0,
    45,
    90,
    135,
    180,
    225,
    270,
    315,
  ];

  double _grados = 0;

  void _cerrarSesion() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => const Pantalla()),
    );
  }

  void _abrirMenu() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (sheetContext) => CupertinoActionSheet(
        title: const Text("Menú"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(sheetContext),
            child: const Text("Rotador"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const AutosPage()),
              );
            },
            child: const Text("Autos JDM"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const HistorialPage()),
              );
            },
            child: const Text("Historial"),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(sheetContext);
              _cerrarSesion();
            },
            child: const Text("Cerrar sesión"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(sheetContext),
          child: const Text("Cancelar"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _abrirMenu,
          child: const Icon(CupertinoIcons.bars, color: AppColors.accent),
        ),
        middle: const Text("Rotador de Rust"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _cerrarSesion,
          child: const Icon(
            CupertinoIcons.square_arrow_right,
            color: AppColors.accent,
          ),
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 220,
                          height: 220,
                          padding: const EdgeInsets.all(36),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.surface,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 40,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: AnimatedRotation(
                            turns: _grados / 360,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Image.asset('assets/images/rust_logo.png'),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          "${_grados.round()}°",
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CupertinoSlider(
                          value: _grados,
                          min: 0,
                          max: 360,
                          divisions: 360,
                          activeColor: AppColors.accent,
                          onChanged: (value) {
                            setState(() {
                              _grados = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: _gradosPreestablecidos.map((valor) {
                            final seleccionado = _grados == valor;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _grados = valor;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: seleccionado
                                      ? AppColors.accent
                                      : AppColors.surface,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${valor.round()}°",
                                  style: TextStyle(
                                    color: seleccionado
                                        ? CupertinoColors.white
                                        : AppColors.textSecondary,
                                    fontWeight: seleccionado
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
