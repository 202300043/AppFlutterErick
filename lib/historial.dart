import 'package:flutter/cupertino.dart';

import 'data/historial_service.dart';
import 'theme.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  late Future<String> _historialFuture;

  @override
  void initState() {
    super.initState();
    _historialFuture = HistorialService.instance.leerHistorial();
  }

  void _recargar() {
    setState(() {
      _historialFuture = HistorialService.instance.leerHistorial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Historial"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _recargar,
          child: const Icon(CupertinoIcons.refresh, color: AppColors.accent),
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<String>(
          future: _historialFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CupertinoActivityIndicator());
            }

            final contenido = snapshot.data ?? '';
            final lineas = contenido
                .split('\n')
                .where((linea) => linea.trim().isNotEmpty)
                .toList()
                .reversed
                .toList();

            if (lineas.isEmpty) {
              return const Center(
                child: Text(
                  "Sin actividad registrada todavía",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: lineas.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    lineas[index],
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
