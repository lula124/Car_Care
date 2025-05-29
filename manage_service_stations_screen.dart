// screens/manage_service_stations_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../services/auth_service.dart';
import 'add_service_station_screen.dart';

class ManageServiceStationsScreen extends StatefulWidget {
  const ManageServiceStationsScreen({Key? key}) : super(key: key);

  @override
  State<ManageServiceStationsScreen> createState() => _ManageServiceStationsScreenState();
}

class _ManageServiceStationsScreenState extends State<ManageServiceStationsScreen> {
  final DatabaseReference _stationsRef = FirebaseDatabase.instance.ref('service_stations');
  final AuthService _authService = AuthService();

  Stream<List<Map<String, dynamic>>> _getMyServiceStations() {
    final userId = _authService.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]);
    }

    return _stationsRef
        .orderByChild('ownerId')
        .equalTo(userId)
        .onValue
        .map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];

      return data.entries.map((entry) {
        final stationData = Map<String, dynamic>.from(entry.value as Map);
        return {
          'id': entry.key,
          ...stationData,
        };
      }).toList();
    });
  }

  Future<void> _deleteStation(String stationId) async {
    try {
      await _stationsRef.child(stationId).remove();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service station deleted successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Service Stations'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getMyServiceStations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final stations = snapshot.data ?? [];

          if (stations.isEmpty) {
            return const Center(
              child: Text('You haven\'t added any service stations yet.'),
            );
          }

          return ListView.builder(
            itemCount: stations.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final station = stations[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        station['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Address: ${station['address'] ?? ''}'),
                      Text('Phone: ${station['phoneNumber'] ?? ''}'),
                      Text('Email: ${station['email'] ?? ''}'),
                      const SizedBox(height: 8),
                      Text(
                        'Services: ${(station['services'] as List<dynamic>?)?.join(', ') ?? ''}',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Edit functionality (you can implement this later)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Edit functionality coming soon')),
                              );
                            },
                            child: const Text('Edit'),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () => _deleteStation(station['id']),
                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
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
              builder: (context) => const AddServiceStationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Service Station',
      ),
    );
  }
}
