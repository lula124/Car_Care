// screens/more_maintenance_items_screen.dart
import 'package:flutter/material.dart';

class MoreMaintenanceItemsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> maintenanceItems;

  const MoreMaintenanceItemsScreen({Key? key, required this.maintenanceItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Upcoming Maintenance'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: maintenanceItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = maintenanceItems[index];
          final String urgencyText = item['dueIn'] <= 0
              ? 'OVERDUE'
              : 'in ${item['dueIn']} km';
          final Color urgencyColor =
          item['dueIn'] <= 0 ? Colors.red : Colors.amber.shade800;

          return Card(
            color: item['dueIn'] <= 0
                ? Colors.red.shade50
                : Colors.amber.shade50,
            child: ListTile(
              leading: Icon(
                item['dueIn'] <= 0 ? Icons.error : Icons.build,
                color: urgencyColor,
              ),
              title: Text(
                '${item['vehicle']}: ${item['maintenance']}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                urgencyText,
                style: TextStyle(
                  color: urgencyColor,
                  fontWeight: item['dueIn'] <= 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
