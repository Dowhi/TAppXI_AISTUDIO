import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calendario_familiar/core/models/local_user.dart';

class UserFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';
  static const String _familyId = 'default_family';

  /// Obtener todos los usuarios de Firebase
  Stream<List<LocalUser>> getUsersStream() {
    return _firestore
        .collection(_usersCollection)
        .where('familyId', isEqualTo: _familyId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        // Si no hay usuarios en Firebase, retornar usuarios por defecto
        return localUsers;
      }
      
      final users = snapshot.docs.map((doc) {
        final data = doc.data();
        final Object? colorValue = data['colorValue'];
        final String? colorHex = data['color'] as String?;
        return LocalUser(
          id: (data['id'] as num).toInt(),
          name: data['name'] as String,
          color: colorValue is num
              ? Color((colorValue as num).toInt())
              : _colorFromHex(colorHex ?? '#2196F3'),
        );
      }).toList();
      
      // Ordenar por ID después de obtener los datos
      users.sort((a, b) => a.id.compareTo(b.id));
      return users;
    });
  }

  /// Obtener usuarios como Future
  Future<List<LocalUser>> getUsers() async {
    try {
      final snapshot = await _firestore
          .collection(_usersCollection)
          .where('familyId', isEqualTo: _familyId)
          .get();

      if (snapshot.docs.isEmpty) {
        // Si no hay usuarios, crear los usuarios por defecto
        await _initializeDefaultUsers();
        return localUsers;
      }

      final users = snapshot.docs.map((doc) {
        final data = doc.data();
        final Object? colorValue = data['colorValue'];
        final String? colorHex = data['color'] as String?;
        return LocalUser(
          id: (data['id'] as num).toInt(),
          name: data['name'] as String,
          color: colorValue is num
              ? Color((colorValue as num).toInt())
              : _colorFromHex(colorHex ?? '#2196F3'),
        );
      }).toList();
      
      // Ordenar por ID después de obtener los datos
      users.sort((a, b) => a.id.compareTo(b.id));
      return users;
    } catch (e) {
      print('Error obteniendo usuarios: $e');
      return localUsers;
    }
  }

  /// Inicializar usuarios por defecto en Firebase desde localUsers
  Future<void> _initializeDefaultUsers() async {
    try {
      final batch = _firestore.batch();

      // Sincronizar los usuarios locales predefinidos con Firebase
      for (final user in localUsers) {
        final docRef = _firestore
            .collection(_usersCollection)
            .doc('${_familyId}_user_${user.id}');

        batch.set(docRef, {
          'id': user.id,
          'name': user.name,
          'color': _colorToHex(user.color),
          'colorValue': user.color.value,
          'familyId': _familyId,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      print('✅ Usuarios locales sincronizados con Firebase: ${localUsers.length} usuarios');
    } catch (e) {
      print('❌ Error sincronizando usuarios locales con Firebase: $e');
    }
  }
  
  /// Sincronizar usuarios locales con Firebase (forzar actualización)
  Future<void> syncLocalUsersToFirebase() async {
    try {
      final batch = _firestore.batch();

      for (final user in localUsers) {
        final docRef = _firestore
            .collection(_usersCollection)
            .doc('${_familyId}_user_${user.id}');

        batch.set(docRef, {
          'id': user.id,
          'name': user.name,
          'color': _colorToHex(user.color),
          'familyId': _familyId,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      await batch.commit();
      print('✅ Sincronización forzada completada: ${localUsers.length} usuarios');
    } catch (e) {
      print('❌ Error en sincronización forzada: $e');
      rethrow;
    }
  }

  /// Agregar un nuevo usuario
  Future<void> addUser({
    required int id,
    required String name,
    required String colorHex,
  }) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc('${_familyId}_user_$id')
          .set({
        'id': id,
        'name': name,
        'color': colorHex,
        'colorValue': _colorFromHex(colorHex).value,
        'familyId': _familyId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('✅ Usuario agregado: $name');
    } catch (e) {
      print('❌ Error agregando usuario: $e');
      rethrow;
    }
  }

  /// Actualizar un usuario
  Future<void> updateUser({
    required int id,
    required String name,
    required String colorHex,
  }) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc('${_familyId}_user_$id')
          .update({
        'name': name,
        'color': colorHex,
        'colorValue': _colorFromHex(colorHex).value,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('✅ Usuario actualizado: $name');
    } catch (e) {
      print('❌ Error actualizando usuario: $e');
      rethrow;
    }
  }

  /// Eliminar un usuario
  Future<void> deleteUser(int id) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc('${_familyId}_user_$id')
          .delete();
      print('✅ Usuario eliminado: $id');
    } catch (e) {
      print('❌ Error eliminando usuario: $e');
      rethrow;
    }
  }

  /// Convertir color a hex
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  /// Convertir hex a color
  Color _colorFromHex(String hex) {
    final hexCode = hex.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}

