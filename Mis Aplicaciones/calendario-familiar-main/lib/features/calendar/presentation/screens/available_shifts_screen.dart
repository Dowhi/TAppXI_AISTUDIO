import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:calendario_familiar/core/models/shift_template.dart';
import 'package:calendario_familiar/core/providers/firebase_shift_templates_provider.dart';
import 'package:calendario_familiar/core/services/firestore_service.dart';

class AvailableShiftsScreen extends ConsumerStatefulWidget {
  const AvailableShiftsScreen({super.key});

  @override
  ConsumerState<AvailableShiftsScreen> createState() => _AvailableShiftsScreenState();
}

class _AvailableShiftsScreenState extends ConsumerState<AvailableShiftsScreen> {
  @override
  void initState() {
    super.initState();
    // Ya no necesitamos cargar manualmente, el Stream lo hace automáticamente
  }

  @override
  Widget build(BuildContext context) {
    final templatesAsync = ref.watch(firebaseShiftTemplatesStreamProvider);
    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_downward, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'TURNOS DISPONIBLES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: templatesAsync.when(
        data: (templates) => Column(
          children: [
            // Botones de acción
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      'CREAR TURNO NUEVO',
                      Icons.add,
                      () {
                        context.push('/shift-configuration');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Eliminado botón de sincronizar para forzar uso solo de Firebase
                ],
              ),
            ),
            
            // Lista de turnos
            Expanded(
              child: templates.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay turnos disponibles',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Crea tu primer turno o sincroniza',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: templates.length,
                      itemBuilder: (context, index) {
                        final template = templates[index];
                        return _buildShiftItem(template);
                      },
                    ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Error al cargar turnos',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  error.toString(),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftItem(ShiftTemplate template) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getShiftColor(template),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              _getShiftAbbreviation(template),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          template.abbreviation.isNotEmpty ? template.abbreviation : template.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '${template.startTime} - ${template.endTime}',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_vert, color: Colors.grey[400]),
          onPressed: () {
            _showShiftOptions(template);
          },
        ),
        onTap: () {
          context.push('/shift-configuration', extra: template);
        },
      ),
    );
  }

  Color _getShiftColor(ShiftTemplate template) {
    // Usar el color real del template en lugar de generar uno automáticamente
    try {
      return Color(int.parse(template.colorHex.replaceFirst('#', '0xFF')));
    } catch (e) {
      // Si hay error al parsear el color, usar color por defecto
      print('❌ Error parseando color ${template.colorHex}: $e');
      return Colors.grey;
    }
  }

  String _getShiftAbbreviation(ShiftTemplate template) {
    // Usar la abreviatura del template si existe
    if (template.abbreviation.isNotEmpty) {
      return template.abbreviation;
    }
    
    // Abreviación por defecto: primeras 2-3 letras del nombre
    return template.name.length > 3 
        ? template.name.substring(0, 3).toUpperCase()
        : template.name.toUpperCase();
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _showShiftOptions(ShiftTemplate template) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[800],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text('Editar', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Navegar a la pantalla de configuración con el template para editar
                context.push('/shift-configuration', extra: template);
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.white),
              title: const Text('Duplicar', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar duplicación
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Función en desarrollo')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Eliminar', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(template);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showShiftDetails(ShiftTemplate template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[800],
        title: Text(
          template.name,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (template.description != null && template.description!.isNotEmpty)
              Text(
                template.description!,
                style: TextStyle(color: Colors.grey[300]),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${template.startTime} - ${template.endTime}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.palette, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _getShiftColor(template),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Color: ${_getShiftColor(template).toString()}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(ShiftTemplate template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Eliminar Turno',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '¿Estás seguro de que quieres eliminar el turno "${template.name}"?',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteShift(template);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteShift(ShiftTemplate template) async {
    // Mostrar diálogo de opciones de eliminación
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Eliminar Turno',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Qué quieres eliminar del turno "${template.name}"?',
              style: TextStyle(color: Colors.grey[300]),
            ),
            const SizedBox(height: 16),
            const Text(
              '• Solo la plantilla: Elimina únicamente la plantilla del turno',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Plantilla y turnos asignados: Elimina la plantilla y todos los turnos ya asignados en el calendario',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'template_only'),
            child: const Text('Solo plantilla', style: TextStyle(color: Colors.orange)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'template_and_shifts'),
            child: const Text('Plantilla y turnos', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (result == null || result == 'cancel') {
      return;
    }

    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      
      if (result == 'template_only') {
        // Eliminar solo la plantilla (sin limpiar turnos asignados)
        await firestoreService.deleteShiftTemplateOnly(template.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Plantilla "${template.name}" eliminada (turnos asignados conservados)'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else if (result == 'template_and_shifts') {
        // Eliminar plantilla y limpiar turnos asignados
        await firestoreService.deleteShiftTemplate(template.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Plantilla "${template.name}" y todos los turnos asignados eliminados'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
      
      // No actualizamos estado manualmente; el Stream reflejará el cambio
      
    } catch (e) {
      print('❌ Error eliminando turno de Firebase: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error eliminando turno de Firebase: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
