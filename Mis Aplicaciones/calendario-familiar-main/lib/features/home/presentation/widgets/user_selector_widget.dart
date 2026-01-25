import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:calendario_familiar/core/providers/current_user_provider.dart';
import 'package:calendario_familiar/core/providers/firebase_users_provider.dart';
import 'package:calendario_familiar/core/models/local_user.dart';

class UserSelectorWidget extends ConsumerWidget {
  const UserSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentUserIdProvider);
    final currentUser = ref.watch(currentUserProvider);
    final usersAsync = ref.watch(firebaseUsersStreamProvider);

    return usersAsync.when(
      data: (users) {
        // Usar usuarios de Firebase si están disponibles, sino usar usuarios locales
        final usersToShow = users.isNotEmpty ? users : localUsers;
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Grid de usuarios
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: usersToShow.length,
                itemBuilder: (context, index) {
                  final user = usersToShow[index];
                  final isSelected = currentUserId == user.id;

                  return _buildUserCard(
                    context: context,
                    ref: ref,
                    user: user,
                    isSelected: isSelected,
                  );
                },
              ),
              const SizedBox(height: 20),

              // Información del usuario seleccionado
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: currentUser.color.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    // Avatar del usuario
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: currentUser.color,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: currentUser.color.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          currentUser.name[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Información del usuario
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Usuario ${currentUser.id}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Indicador de selección
                    Icon(
                      Icons.check_circle,
                      color: currentUser.color,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => _buildFallbackUsers(ref, currentUserId),
      error: (_, __) => _buildFallbackUsers(ref, currentUserId),
    );
  }

  /// Construir usuarios de fallback cuando Firebase falle (especialmente en iOS/Safari)
  Widget _buildFallbackUsers(WidgetRef ref, int currentUserId) {
    final currentUser = ref.watch(currentUserProvider);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Grid de usuarios locales como fallback
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: localUsers.length,
            itemBuilder: (context, index) {
              final user = localUsers[index];
              final isSelected = currentUserId == user.id;

              return _buildUserCard(
                context: context,
                ref: ref,
                user: user,
                isSelected: isSelected,
              );
            },
          ),
          const SizedBox(height: 20),

          // Información del usuario seleccionado
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: currentUser.color.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                // Avatar del usuario
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: currentUser.color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: currentUser.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      currentUser.name[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Información del usuario
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Usuario ${currentUser.id}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Indicador de selección
                Icon(
                  Icons.check_circle,
                  color: currentUser.color,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard({
    required BuildContext context,
    required WidgetRef ref,
    required LocalUser user,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        try {
          // Cambiar usuario actual
          await ref.read(currentUserIdProvider.notifier).setCurrentUser(user.id);
          
          // Navegar al calendario con manejo de errores para iOS Safari
          if (context.mounted) {
            // Usar un delay para asegurar que el estado se actualice correctamente
            await Future.delayed(const Duration(milliseconds: 100));
            
            if (context.mounted) {
              // Intentar navegación normal primero
              try {
                context.go('/calendar');
              } catch (e) {
                print('⚠️ Error en navegación normal, usando fallback: $e');
                // Fallback para iOS Safari: usar push en lugar de go
                if (context.mounted) {
                  context.push('/calendar');
                }
              }
            }
          }
        } catch (e) {
          print('❌ Error en selección de usuario: $e');
          // Mostrar mensaje de error al usuario
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error seleccionando usuario: ${e.toString()}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected 
              ? user.color.withOpacity(0.9)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
                ? user.color
                : Colors.white.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: user.color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar del usuario
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected 
                    ? Colors.white
                    : user.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  user.name[0],
                  style: TextStyle(
                    color: isSelected 
                        ? user.color
                        : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Nombre del usuario
            Text(
              user.name,
              style: TextStyle(
                color: isSelected 
                    ? Colors.white
                    : Colors.white.withOpacity(0.9),
                fontSize: 12,
                fontWeight: isSelected 
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Indicador de selección
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF1B5E20),
                  size: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
