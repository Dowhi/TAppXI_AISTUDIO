import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendario_familiar/core/models/shift_template.dart';
import 'package:calendario_familiar/core/services/shift_template_firebase_service.dart';

// Provider del servicio de plantillas de turnos de Firebase
final shiftTemplateFirebaseServiceProvider = Provider<ShiftTemplateFirebaseService>((ref) {
  return ShiftTemplateFirebaseService();
});

// Provider para obtener plantillas desde Firebase (Stream)
final firebaseShiftTemplatesStreamProvider = StreamProvider<List<ShiftTemplate>>((ref) {
  final service = ref.watch(shiftTemplateFirebaseServiceProvider);
  return service.getShiftTemplatesStream();
});

// Provider para obtener plantillas desde Firebase (Future)
final firebaseShiftTemplatesProvider = FutureProvider<List<ShiftTemplate>>((ref) async {
  final service = ref.watch(shiftTemplateFirebaseServiceProvider);
  return service.getShiftTemplates();
});

