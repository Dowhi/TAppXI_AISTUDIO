import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendario_familiar/core/models/local_user.dart';
import 'package:calendario_familiar/core/services/user_firebase_service.dart';

// Provider del servicio de usuarios de Firebase
final userFirebaseServiceProvider = Provider<UserFirebaseService>((ref) {
  return UserFirebaseService();
});

// Provider para obtener usuarios desde Firebase (Stream)
final firebaseUsersStreamProvider = StreamProvider<List<LocalUser>>((ref) {
  final service = ref.watch(userFirebaseServiceProvider);
  return service.getUsersStream();
});

// Provider para obtener usuarios desde Firebase (Future)
final firebaseUsersProvider = FutureProvider<List<LocalUser>>((ref) async {
  final service = ref.watch(userFirebaseServiceProvider);
  return service.getUsers();
});

