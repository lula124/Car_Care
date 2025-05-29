// screens/vehicle_list_screen.dart
import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import '../services/auth_service.dart';
import '../services/vehicle_service.dart';
import 'add_vehicle_screen.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({Key? key}) : super(key: key);

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  final VehicleService _vehicleService = VehicleService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final userId = _authService.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicles'),
      ),
      body: userId == null
          ? const Center(child: Text('Please login to view your vehicles'))
          : StreamBuilder<List<Vehicle>>(
        stream: _vehicleService.getUserVehicles(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final vehicles = snapshot.data ?? [];

          if (vehicles.isEmpty) {
            return const Center(
              child: Text('No vehicles found. Add your first vehicle!'),
            );
          }

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  leading: const Icon(Icons.directions_car, size: 40),
                  title: Text('${vehicle.make} ${vehicle.model}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Year: ${vehicle.year} • License: ${vehicle.licensePlate}'),
                      Text('Mileage: ${vehicle.mileage} km'), // Display mileage
                    ],
                  ),
                  isThreeLine: true, // Allow for three lines in subtitle
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _vehicleService.deleteVehicle(vehicle.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vehicle deleted successfully'),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddVehicleScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
