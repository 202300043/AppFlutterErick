import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'data/historial_service.dart';
import 'models/auto.dart';
import 'repositories/auto_repository.dart';
import 'services/notification_service.dart';
import 'theme.dart';
import 'widgets/auto_card.dart';
import 'widgets/auto_form_dialog.dart';

class AutosPage extends StatefulWidget {
  const AutosPage({super.key});

  @override
  State<AutosPage> createState() => _AutosPageState();
}

class _AutosPageState extends State<AutosPage> {
  final AutoRepository _repository = AutoRepository();

  late Future<List<Auto>> _autosFuture;
  Timer? _autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    _autosFuture = _repository.obtenerAutos();

    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _refrescar();
    });
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    super.dispose();
  }

  void _refrescar() {
    if (!mounted) {
      return;
    }
    setState(() {
      _autosFuture = _repository.obtenerAutos();
    });
  }

  Future<void> _agregarAuto() async {
    final nuevoAuto = await mostrarFormularioAuto(context);
    if (nuevoAuto == null || !mounted) {
      return;
    }

    await _repository.crearAuto(nuevoAuto);
    await HistorialService.instance.registrarEvento(
      "Auto agregado: ${nuevoAuto.marca} ${nuevoAuto.modelo}",
    );
    await NotificationService.instance.mostrarNotificacion(
      titulo: "Auto agregado",
      cuerpo: "${nuevoAuto.marca} ${nuevoAuto.modelo} se agregó al catálogo",
    );

    _refrescar();
  }

  Future<void> _editarAuto(Auto auto) async {
    final autoEditado = await mostrarFormularioAuto(context, autoExistente: auto);
    if (autoEditado == null || !mounted) {
      return;
    }

    await _repository.actualizarAuto(autoEditado);
    await HistorialService.instance.registrarEvento(
      "Auto actualizado: ${autoEditado.marca} ${autoEditado.modelo}",
    );
    await NotificationService.instance.mostrarNotificacion(
      titulo: "Auto actualizado",
      cuerpo: "${autoEditado.marca} ${autoEditado.modelo} se actualizó",
    );

    _refrescar();
  }

  Future<void> _eliminarAuto(Auto auto) async {
    final confirmado = await showCupertinoDialog<bool>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Eliminar auto'),
        content: Text('¿Eliminar ${auto.marca} ${auto.modelo}?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmado != true || !mounted) {
      return;
    }

    await _repository.eliminarAuto(auto);
    await HistorialService.instance.registrarEvento(
      "Auto eliminado: ${auto.marca} ${auto.modelo}",
    );
    await NotificationService.instance.mostrarNotificacion(
      titulo: "Auto eliminado",
      cuerpo: "${auto.marca} ${auto.modelo} se eliminó del catálogo",
    );

    _refrescar();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Autos JDM"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _agregarAuto,
          child: const Icon(CupertinoIcons.add, color: AppColors.accent),
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<List<Auto>>(
          future: _autosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    "No se pudo cargar el catálogo JDM.\n${snapshot.error}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              );
            }

            final autos = snapshot.data ?? [];

            if (autos.isEmpty) {
              return const Center(
                child: Text(
                  "Sin autos disponibles",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                CupertinoSliverRefreshControl(onRefresh: () async => _refrescar()),
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList.separated(
                    itemCount: autos.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final auto = autos[index];
                      return AutoCard(
                        auto: auto,
                        onEditar: () => _editarAuto(auto),
                        onEliminar: () => _eliminarAuto(auto),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
