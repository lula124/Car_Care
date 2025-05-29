// screens/ev_station_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/ev_station_model.dart';

class EVStationDetailScreen extends StatelessWidget {
  final EVStation station;
  const EVStationDetailScreen({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(station.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${station.address}'),
            const SizedBox(height: 8),
            Text('Description: ${station.description}'),
            const SizedBox(height: 8),
            Text('Connectors: ${station.connectorTypes.join(', ')}'),
            const SizedBox(height: 8),
            Text('Availability: ${station.isAvailable ? 'Available' : 'Unavailable'}'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.navigation),
              label: const Text('Navigate'),
              onPressed: () {
                // Use url_launcher to open Google Maps with station.latitude, station.longitude
              },
            ),
          ],
        ),
      ),
    );
  }
}
