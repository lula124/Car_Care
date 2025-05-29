// screens/service_stations_screen.dart
import 'package:flutter/material.dart';
import '../models/service_station_model.dart';
import '../services/booking_service.dart';
import 'booking_calendar_screen.dart';
import 'service_station_detail_screen.dart';

class ServiceStationsScreen extends StatefulWidget {
  const ServiceStationsScreen({Key? key}) : super(key: key);

  @override
  State<ServiceStationsScreen> createState() => _ServiceStationsScreenState();
}

class _ServiceStationsScreenState extends State<ServiceStationsScreen> {
  final BookingService _bookingService = BookingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Stations'),
      ),
      body: StreamBuilder<List<ServiceStation>>(
        stream: _bookingService.getServiceStations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final stations = snapshot.data ?? [];

          if (stations.isEmpty) {
            return const Center(child: Text('No service stations available'));
          }

          return ListView.builder(
            itemCount: stations.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final station = stations[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceStationDetailScreen(station: station),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          station.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(station.address),
                        Text('Phone: ${station.phoneNumber}'),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Tap for details',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
