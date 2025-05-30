// screens/vehicle_details_screen.dart
import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import '../models/maintenance_record_model.dart';
import '../services/maintenance_service.dart';
import 'add_maintenance_record_screen.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final Vehicle vehicle;

  const VehicleDetailsScreen({Key? key, required this.vehicle}) : super(key: key);

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final MaintenanceService _maintenanceService = MaintenanceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.vehicle.make} ${widget.vehicle.model} Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vehicle info card
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.vehicle.make} ${widget.vehicle.model} (${widget.vehicle.year})',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('License Plate: ${widget.vehicle.licensePlate}'),
                  Text('Current Mileage: ${widget.vehicle.mileage} km'),
                ],
              ),
            ),
          ),

          // Maintenance records header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Maintenance Records',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add New'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMaintenanceRecordScreen(
                          vehicleId: widget.vehicle.id,
                          currentMileage: widget.vehicle.mileage, // Pass the current mileage
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Maintenance records list
          Expanded(
            child: StreamBuilder<List<MaintenanceRecord>>(
              stream: _maintenanceService.getMaintenanceRecords(widget.vehicle.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final records = snapshot.data ?? [];

                if (records.isEmpty) {
                  return const Center(
                    child: Text('No maintenance records found'),
                  );
                }

                return ListView.builder(
                  itemCount: records.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: ListTile(
                        title: Text(
                          record.type,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${record.date}'),
                            Text('Mileage: ${record.mileage} km'),
                            if (record.notes.isNotEmpty) Text('Notes: ${record.notes}'),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await _maintenanceService.deleteMaintenanceRecord(record.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Record deleted')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMaintenanceRecordScreen(
                vehicleId: widget.vehicle.id,
                currentMileage: widget.vehicle.mileage, // Pass the current mileage
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Maintenance Record',
      ),
    );
  }
}
