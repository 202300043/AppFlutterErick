import 'package:flutter/cupertino.dart';

import 'inicio.dart';
import 'registro.dart';
import 'terminos.dart';
import 'data/auth_database.dart';
import 'data/historial_service.dart';
import 'services/notification_service.dart';
import 'theme.dart';
import 'utils/dialogs.dart';
import 'utils/validadores.dart';
import 'widgets/campo_texto.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await AuthDatabase.instance.database;
  } catch (error) {
    debugPrint("No se pudo inicializar la base de datos local: $error");
  }

  try {
    await NotificationService.instance.inicializar();
  } catch (error) {
    debugPrint("No se pudo inicializar las notificaciones: $error");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Rust Rotator',
      debugShowCheckedModeBanner: false,
      theme: appCupertinoTheme,
      home: const Pantalla(),
    );
  }
}

class Pantalla extends StatefulWidget {
  const Pantalla({super.key});

  @override
  State<Pantalla> createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  final TextEditingController correoController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode correoFocusNode = FocusNode();

  final FocusNode passwordFocusNode = FocusNode();

  Color colorCorreo = AppColors.textPrimary;

  bool aceptaTerminos = false;

  bool cargando = false;

  void validarCorreo() {
    String correo = correoController.text.trim();

    bool esValido = esCorreoValido(correo);

    setState(() {
      colorCorreo = correo.isEmpty
          ? AppColors.textPrimary
          : (esValido ? AppColors.success : AppColors.danger);
    });
  }

  void _irAlCampoContrasena() {
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  Future<void> iniciarSesion() async {
    validarCorreo();

    final correoIngresado = correoController.text.trim();
    final passwordIngresado = passwordController.text;

    if (correoIngresado.isEmpty || passwordIngresado.isEmpty) {
      await mostrarAviso(context, "Completa correo y contraseña");
      return;
    }

    if (!aceptaTerminos) {
      await mostrarAviso(context, "Debes aceptar los términos y condiciones");
      return;
    }

    setState(() {
      cargando = true;
    });

    final autenticado = await AuthDatabase.instance.authenticateUser(
      email: correoIngresado,
      password: passwordIngresado,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      cargando = false;
    });

    if (!autenticado) {
      await mostrarAviso(context, "Correo o contraseña incorrectos");
      return;
    }

    await HistorialService.instance.registrarEvento(
      "Inicio de sesión: $correoIngresado",
    );

    await NotificationService.instance.mostrarNotificacion(
      titulo: "Bienvenido de nuevo",
      cuerpo: "Sesión iniciada correctamente",
    );

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => const InicioPage()),
    );
  }

  @override
  void dispose() {
    correoController.dispose();
    passwordController.dispose();
    correoFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Iniciar sesión"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.25),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Image.asset('assets/images/rust_logo.png'),
              ),
              const SizedBox(height: 32),

              CampoTexto(
                controller: correoController,
                focusNode: correoFocusNode,
                placeholder: "Correo",
                keyboardType: TextInputType.emailAddress,
                textColor: colorCorreo,
                onChanged: (_) => validarCorreo(),
                onSubmitted: (_) => _irAlCampoContrasena(),
              ),

              const SizedBox(height: 16),

              CampoTexto(
                controller: passwordController,
                focusNode: passwordFocusNode,
                placeholder: "Contraseña",
                obscureText: true,
                onSubmitted: (_) => iniciarSesion(),
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoSwitch(
                    value: aceptaTerminos,
                    activeTrackColor: AppColors.accent,
                    onChanged: (value) {
                      setState(() {
                        aceptaTerminos = value;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "Acepto los ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const TerminosPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Términos y Condiciones",
                            style: TextStyle(
                              color: AppColors.accent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: cargando ? null : iniciarSesion,
                  child: cargando
                      ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                      : const Text("Iniciar Sesión"),
                ),
              ),

              const SizedBox(height: 8),

              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const RegistroPage(),
                    ),
                  );
                },
                child: const Text(
                  "Crear una cuenta",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
