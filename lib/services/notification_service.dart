import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  int _idContador = 0;
  bool _inicializado = false;

  Future<void> inicializar() async {
    if (_inicializado) {
      return;
    }

    const configuracionAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const configuracionDarwin = DarwinInitializationSettings();

    const configuracion = InitializationSettings(
      android: configuracionAndroid,
      iOS: configuracionDarwin,
      macOS: configuracionDarwin,
    );

    await _plugin.initialize(configuracion);

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    _inicializado = true;
  }

  Future<void> mostrarNotificacion({
    required String titulo,
    required String cuerpo,
  }) async {
    if (!_inicializado) {
      await inicializar();
    }

    const detallesAndroid = AndroidNotificationDetails(
      'acciones_app',
      'Acciones de la aplicación',
      channelDescription: 'Notificaciones generadas por acciones del usuario',
      importance: Importance.high,
      priority: Priority.high,
    );

    const detalles = NotificationDetails(
      android: detallesAndroid,
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );

    _idContador++;
    await _plugin.show(_idContador, titulo, cuerpo, detalles);
  }
}
