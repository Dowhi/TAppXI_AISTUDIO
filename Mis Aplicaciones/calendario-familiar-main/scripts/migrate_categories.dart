import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:calendario_familiar/core/firebase/firebase_options.dart';
import 'dart:io';

/// Script de migración para actualizar nombres de categorías antiguas
/// 
/// Este script:
/// 1. Busca "Ingreso" y lo reemplaza por "Pago"
/// 2. Busca "Mascota" y lo reemplaza por "Cumpleaños"
/// 3. Actualiza en la colección calendar_events donde las categorías están en el array events

Future<void> main() async {
  print('🚀 Iniciando migración de categorías...');
  print('📅 Fecha: ${DateTime.now()}');
  print('=' * 50);
  
  try {
    // Inicializar Firebase
    print('🔧 Inicializando Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase inicializado correctamente');
    
    // Verificar que las credenciales de Firebase estén disponibles
    final firestore = FirebaseFirestore.instance;
    
    print('🔍 Verificando conectividad con Firebase...');
    await _testConnection(firestore);
    
    // Migrar categorías en calendar_events
    await _migrateCalendarEventsCategories(firestore);
    
    print('\n🎉 Migración completada exitosamente!');
    
  } catch (e, stackTrace) {
    print('❌ Error durante la migración: $e');
    print('📋 Stack trace: $stackTrace');
    exit(1);
  }
}

Future<void> _testConnection(FirebaseFirestore firestore) async {
  try {
    // Intentar leer un documento de test
    await firestore.collection('calendar_events').limit(1).get();
    print('✅ Conexión a Firebase exitosa');
  } catch (e) {
    print('❌ Error conectando a Firebase: $e');
    print('💡 Asegúrate de tener las credenciales de Firebase configuradas');
    rethrow;
  }
}

Future<void> _migrateCalendarEventsCategories(FirebaseFirestore firestore) async {
  print('\n🔄 Migrando categorías en calendar_events...');
  
  try {
    final snapshot = await firestore.collection('calendar_events').get();
    print('📊 Documentos encontrados: ${snapshot.docs.length}');
    
    int updatedDocs = 0;
    int totalCategories = 0;
    
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final events = data['events'] as List?;
      
      if (events == null || events.isEmpty) {
        continue;
      }
      
      bool needsUpdate = false;
      final updatedEvents = <Map<String, dynamic>>[];
      
      for (final event in events) {
        if (event is! Map<String, dynamic>) continue;
        
        final eventCopy = Map<String, dynamic>.from(event);
        
        // Verificar si es un evento de tipo nota
        if (event['type'] == 'note') {
          final categories = event['categories'] as List?;
          
          if (categories != null && categories.isNotEmpty) {
            final updatedCategories = <Map<String, dynamic>>[];
            
            for (final category in categories) {
              if (category is Map<String, dynamic>) {
                final categoryCopy = Map<String, dynamic>.from(category);
                final categoryText = category['text'] as String?;
                
                // Reemplazar "Ingreso" por "Pago"
                if (categoryText == 'Ingreso') {
                  categoryCopy['text'] = 'Pago';
                  categoryCopy['icon'] = '💳';
                  needsUpdate = true;
                  totalCategories++;
                  print('  ✏️ "Ingreso" → "Pago" en ${doc.id}');
                }
                // Reemplazar "Mascota" por "Cumpleaños"
                else if (categoryText == 'Mascota') {
                  categoryCopy['text'] = 'Cumpleaños';
                  categoryCopy['icon'] = '🎂';
                  needsUpdate = true;
                  totalCategories++;
                  print('  ✏️ "Mascota" → "Cumpleaños" en ${doc.id}');
                }
                
                updatedCategories.add(categoryCopy);
              }
            }
            
            eventCopy['categories'] = updatedCategories;
          }
        }
        
        updatedEvents.add(eventCopy);
      }
      
      // Actualizar el documento si hubo cambios
      if (needsUpdate) {
        await doc.reference.update({'events': updatedEvents});
        print('✅ Documento ${doc.id} actualizado');
        updatedDocs++;
      }
    }
    
    print('\n📈 Resumen de migración:');
    print('   📄 Documentos actualizados: $updatedDocs');
    print('   🏷️ Categorías migradas: $totalCategories');
    
  } catch (e) {
    print('❌ Error migrando calendar_events: $e');
    rethrow;
  }
}

