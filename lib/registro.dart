import 'package:flutter/cupertino.dart';

import 'data/auth_database.dart';
import 'data/historial_service.dart';
import 'services/notification_service.dart';
import 'utils/dialogs.dart';
import 'utils/validadores.dart';
import 'widgets/campo_texto.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmarController = TextEditingController();

  bool cargando = false;

  Future<void> registrar() async {
    final nombre = nombreController.text.trim();
    final correo = correoController.text.trim();
    final password = passwordController.text;
    final confirmar = confirmarController.text;

    if (nombre.isEmpty) {
      await mostrarAviso(context, "Ingresa tu nombre");
      return;
    }

    if (!esCorreoValido(correo)) {
      await mostrarAviso(context, "Ingresa un correo válido");
      return;
    }

    if (password.length < 6) {
      await mostrarAviso(
        context,
        "La contraseña debe tener al menos 6 caracteres",
      );
      return;
    }

    if (password != confirmar) {
      await mostrarAviso(context, "Las contraseñas no coinciden");
      return;
    }

    setState(() {
      cargando = true;
    });

    final creado = await AuthDatabase.instance.registerUser(
      nombre: nombre,
      email: correo,
      password: password,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      cargando = false;
    });

    if (!creado) {
      await mostrarAviso(context, "Ese correo ya está registrado");
      return;
    }

    await HistorialService.instance.registrarEvento(
      "Registro de cuenta: $correo",
    );

    await NotificationService.instance.mostrarNotificacion(
      titulo: "Registro exitoso",
      cuerpo: "Tu cuenta se creó correctamente",
    );

    if (!mounted) {
      return;
    }

    await mostrarAviso(context, "Cuenta creada, ya puedes iniciar sesión");
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    passwordController.dispose();
    confirmarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Crear cuenta"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              CampoTexto(controller: nombreController, placeholder: "Nombre"),
              const SizedBox(height: 16),
              CampoTexto(
                controller: correoController,
                placeholder: "Correo",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: passwordController,
                placeholder: "Contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: confirmarController,
                placeholder: "Confirmar contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: cargando ? null : registrar,
                  child: cargando
                      ? const CupertinoActivityIndicator(
                          color: CupertinoColors.white,
                        )
                      : const Text("Registrarme"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
