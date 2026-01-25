import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendario_familiar/core/models/shift_template.dart';
import 'package:calendario_familiar/core/models/local_shift_templates.dart';

class ShiftTemplateFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _templatesCollection = 'shift_templates';
  static const String _familyId = 'default_family';

  /// Obtener todas las plantillas de turnos desde Firebase
  Stream<List<ShiftTemplate>> getShiftTemplatesStream() {
    return _firestore
        .collection(_templatesCollection)
        .where('familyId', isEqualTo: _familyId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        // Si no hay plantillas en Firebase, retornar plantillas locales
        return localShiftTemplates;
      }

      final templates = snapshot.docs.map((doc) {
        final data = doc.data();
        return ShiftTemplate.fromJson(data);
      }).toList();

      // Ordenar por nombre
      templates.sort((a, b) => a.name.compareTo(b.name));
      return templates;
    });
  }

  /// Obtener plantillas como Future
  Future<List<ShiftTemplate>> getShiftTemplates() async {
    try {
      final snapshot = await _firestore
          .collection(_templatesCollection)
          .where('familyId', isEqualTo: _familyId)
          .get();

      if (snapshot.docs.isEmpty) {
        // Si no hay plantillas, inicializar con las locales
        await _initializeLocalTemplates();
        return localShiftTemplates;
      }

      final templates = snapshot.docs.map((doc) {
        final data = doc.data();
        return ShiftTemplate.fromJson(data);
      }).toList();

      // Ordenar por nombre
      templates.sort((a, b) => a.name.compareTo(b.name));
      return templates;
    } catch (e) {
      print('❌ Error obteniendo plantillas de turnos: $e');
      return localShiftTemplates;
    }
  }

  /// Inicializar plantillas locales en Firebase
  Future<void> _initializeLocalTemplates() async {
    try {
      final batch = _firestore.batch();

      for (final template in localShiftTemplates) {
        // Crear un ID único para cada plantilla
        final docRef = _firestore
            .collection(_templatesCollection)
            .doc('${_familyId}_${template.id}');

        final templateData = template.toJson();
        templateData['familyId'] = _familyId;
        templateData['createdAt'] = FieldValue.serverTimestamp();
        templateData['updatedAt'] = FieldValue.serverTimestamp();

        batch.set(docRef, templateData);
      }

      await batch.commit();
      print('✅ Plantillas locales sincronizadas con Firebase: ${localShiftTemplates.length} plantillas');
    } catch (e) {
      print('❌ Error sincronizando plantillas locales con Firebase: $e');
    }
  }

  /// Sincronizar plantillas locales con Firebase (forzar actualización)
  Future<void> syncLocalTemplatesToFirebase() async {
    try {
      final batch = _firestore.batch();

      for (final template in localShiftTemplates) {
        final docRef = _firestore
            .collection(_templatesCollection)
            .doc('${_familyId}_${template.id}');

        final templateData = template.toJson();
        templateData['familyId'] = _familyId;
        templateData['updatedAt'] = FieldValue.serverTimestamp();

        batch.set(docRef, templateData, SetOptions(merge: true));
      }

      await batch.commit();
      print('✅ Sincronización forzada de plantillas completada: ${localShiftTemplates.length} plantillas');
    } catch (e) {
      print('❌ Error en sincronización forzada de plantillas: $e');
      rethrow;
    }
  }

  /// Agregar una nueva plantilla
  Future<void> addTemplate(ShiftTemplate template) async {
    try {
      final docRef = _firestore.collection(_templatesCollection).doc();
      
      final templateData = template.copyWith(
        id: docRef.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson();
      
      templateData['familyId'] = _familyId;
      templateData['createdAt'] = FieldValue.serverTimestamp();
      templateData['updatedAt'] = FieldValue.serverTimestamp();

      await docRef.set(templateData);
      print('✅ Plantilla agregada: ${template.name}');
    } catch (e) {
      print('❌ Error agregando plantilla: $e');
      rethrow;
    }
  }

  /// Actualizar una plantilla
  Future<void> updateTemplate(ShiftTemplate template) async {
    try {
      final templateData = template.toJson();
      templateData['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore
          .collection(_templatesCollection)
          .doc(template.id)
          .update(templateData);
      
      print('✅ Plantilla actualizada: ${template.name}');
    } catch (e) {
      print('❌ Error actualizando plantilla: $e');
      rethrow;
    }
  }

  /// Eliminar una plantilla
  Future<void> deleteTemplate(String templateId) async {
    try {
      await _firestore
          .collection(_templatesCollection)
          .doc(templateId)
          .delete();
      
      print('✅ Plantilla eliminada: $templateId');
    } catch (e) {
      print('❌ Error eliminando plantilla: $e');
      rethrow;
    }
  }
}

