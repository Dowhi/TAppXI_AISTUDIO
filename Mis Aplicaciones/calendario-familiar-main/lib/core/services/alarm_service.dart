import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:calendario_familiar/core/models/app_event.dart';
import 'package:calendario_familiar/routing/app_router.dart';
import 'package:go_router/go_router.dart';

/// Servicio de alarmas para iOS
/// - iOS: programa notificaciones locales con sonido. iOS no permite abrir UI automáticamente;
///   el usuario debe tocar la notificación.
class AlarmService {
  static final FlutterLocalNotificationsPlugin _ln = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static const String _channelId = 'alarm_channel';
  static const String _channelName = 'Alarmas';
  static const String _channelDescription = 'Alarmas de eventos programados';

  /// Debe llamarse en `main()`
  static Future<void> initialize() async {
    if (_initialized) return;
    try {
      const iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const init = InitializationSettings(iOS: iosInit);
      await _ln.initialize(init, onDidReceiveNotificationResponse: _onTap);

      _initialized = true;
      // ignore: avoid_print
      print('✅ AlarmService inicializado para iOS');
    } catch (e) {
      // No propagar para evitar romper el arranque
      // ignore: avoid_print
      print('❌ Error inicializando AlarmService: $e');
    }
  }

  /// Programa una alarma exacta para un `AppEvent`.
  /// `fireAt` es la hora exacta en local time.
  static Future<void> scheduleAlarm({
    required AppEvent event,
    required DateTime fireAt,
    String? notes,
  }) async {
    // ignore: avoid_print
    print('🚨 AlarmService.scheduleAlarm INICIADO para evento: ${event.title} a las $fireAt');
    
    if (!_initialized) await initialize();

    if (kIsWeb) {
      // En web usamos notificaciones programadas locales y AlarmService
      print('🌐 Programando alarma para web...');
      // ignore: avoid_print
      print('🚨 Plataforma WEB detectada, programando notificación web');
      
      try {
        // Calcular tiempo hasta la alarma
        final timeUntilAlarm = fireAt.difference(DateTime.now());
        print('🚨 Tiempo hasta alarma: ${timeUntilAlarm.inSeconds} segundos');
        
        if (timeUntilAlarm.inSeconds <= 0) {
          print('🚨 Alarma en el pasado, mostrando inmediatamente');
          await showImmediateAlarm(
            id: event.id,
            title: event.title,
            notes: notes ?? event.notes ?? 'Es la hora del evento',
            dateKey: event.dateKey,
          );
        } else {
          // Programar notificación simple con Timer
          print('🚨 Programando notificación web para ${timeUntilAlarm.inSeconds} segundos');
          
          // Usar Timer simple de Dart
          Timer(Duration(seconds: timeUntilAlarm.inSeconds), () {
            print('🚨 WEB ALARM DISPARADA: ${event.title}');
            
            // Mostrar notificación inmediata
            showImmediateAlarm(
              id: event.id,
              title: event.title,
              notes: notes ?? event.notes ?? 'Es la hora del evento',
              dateKey: event.dateKey,
            );
            
            // Navegar a la pantalla de alarma
            _navigateToAlarmScreen(event.title, notes ?? event.notes ?? 'Es la hora del evento', event.dateKey);
          });
          
          print('✅ Timer web programado exitosamente para ${timeUntilAlarm.inSeconds} segundos');
        }
      } catch (e) {
        print('❌ Error programando alarma web: $e');
        // Fallback: mostrar notificación inmediata
        await showImmediateAlarm(
          id: event.id,
          title: event.title,
          notes: notes ?? event.notes ?? 'Es la hora del evento',
          dateKey: event.dateKey,
        );
      }
      return;
    }

    // iOS: programar notificación local
    await _ln.zonedSchedule(
      event.id.hashCode,
      '⏰ ${event.title}',
      'Es la hora del evento',
      tz.TZDateTime.from(fireAt, tz.local),
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload:
          'alarm|id=${event.id}|title=${event.title}|notes=${notes ?? event.notes ?? ''}|dateKey=${event.dateKey}',
    );
  }

  /// Cancela una alarma por ID de evento.
  static Future<void> cancelAlarm(String eventId) async {
    if (!_initialized) await initialize();
    try {
      await _ln.cancel(eventId.hashCode);
    } catch (_) {}
  }

  /// Muestra una notificación de alarma inmediata.
  static Future<void> showImmediateAlarm({
    required String id,
    required String title,
    required String notes,
    String? dateKey,
  }) async {
    if (!_initialized) await initialize();
    await _ln.show(
      id.hashCode,
      '⏰ $title',
      notes.isEmpty ? 'Es la hora del evento' : notes,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.critical,
        ),
      ),
      payload:
          'alarm|id=$id|title=$title|notes=$notes|dateKey=${dateKey ?? ''}',
    );
  }

  /// Handler cuando el usuario toca la notificación.
  static void _onTap(NotificationResponse response) {
    final payload = response.payload ?? '';
    print('🔔 AlarmService._onTap llamado con payload: $payload');
    
    if (payload.startsWith('alarm|')) {
      final data = _decodePayload(payload);
      print('🔔 Datos decodificados: $data');
      
      openedFromNotification = true;
      initialAlarmData = data;
      
      // Intentar navegar inmediatamente si la app está activa
      if (navigatorKey.currentState != null && navigatorKey.currentState!.context.mounted) {
        try {
          final uri = Uri(path: '/alarm', queryParameters: data.map((k, v) => MapEntry(k, '$v')));
          print('🔔 Navegando a: ${uri.toString()}');
          navigatorKey.currentState!.context.go(uri.toString());
          print('✅ Navegación exitosa');
        } catch (e) {
          print('❌ Error navegando: $e');
          // Fallback: usar el método de navegación directa
          _navigateToAlarmScreen(data['title'] ?? 'Alarma', data['notes'] ?? '', data['dateKey'] ?? '');
        }
      } else {
        print('⚠️ Navigator no disponible, navegación diferida');
        // La navegación se manejará en app_router.dart cuando la app se inicialice
      }
    } else {
      print('⚠️ Payload no es de alarma: $payload');
    }
  }

  static Map<String, dynamic> _decodePayload(String payload) {
    // Formato: alarm|id=..|title=..|notes=..|dateKey=..
    final parts = payload.split('|');
    final map = <String, String>{};
    for (final p in parts.skip(1)) {
      final i = p.indexOf('=');
      if (i > 0) map[p.substring(0, i)] = Uri.decodeComponent(p.substring(i + 1));
    }
    return {
      'id': map['id'] ?? '',
      'title': map['title'] ?? 'Aviso',
      'notes': map['notes'] ?? '',
      'dateKey': map['dateKey'] ?? '',
    };
  }

  /// Navega a la pantalla de alarma
  static void _navigateToAlarmScreen(String title, String notes, String dateKey) {
    try {
      print('🚨 Intentando navegar a pantalla de alarma...');
      
      if (navigatorKey.currentState != null && navigatorKey.currentState!.context.mounted) {
        navigatorKey.currentState!.context.go(
          Uri(path: '/alarm', queryParameters: {
            'title': title,
            'notes': notes,
            'dateKey': dateKey,
          }).toString(),
        );
        print('✅ Navegación a pantalla de alarma exitosa');
      } else {
        print('❌ Navigator no está disponible, usando fallback');
        // Fallback: usar window.location
        _navigateToAlarmFallback(title, notes, dateKey);
      }
    } catch (e) {
      print('❌ Error navegando a pantalla de alarma: $e');
      // Fallback: usar window.location
      _navigateToAlarmFallback(title, notes, dateKey);
    }
  }

  /// Fallback para navegar a la pantalla de alarma usando window.location
  static void _navigateToAlarmFallback(String title, String notes, String dateKey) {
    if (!kIsWeb) return;
    
    try {
      print('🚨 Usando fallback de navegación...');
      
      // Crear URL con parámetros
      final uri = Uri(path: '/alarm', queryParameters: {
        'title': title,
        'notes': notes,
        'dateKey': dateKey,
      });
      
      // Usar JavaScript para navegar
      // ignore: avoid_print
      print('🚨 Navegando a: ${uri.toString()}');
      
      // En Flutter web, podemos usar html.window.location
      // Pero por simplicidad, vamos a usar un enfoque diferente
      // Intentar navegar usando el router de Flutter después de un delay
      Timer(const Duration(milliseconds: 100), () {
        if (navigatorKey.currentState != null && navigatorKey.currentState!.context.mounted) {
          try {
            navigatorKey.currentState!.context.go(uri.toString());
            print('✅ Navegación fallback exitosa');
          } catch (e) {
            print('❌ Error en navegación fallback: $e');
          }
        }
      });
      
    } catch (e) {
      print('❌ Error en fallback de navegación: $e');
    }
  }
}



