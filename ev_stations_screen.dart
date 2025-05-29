// screens/ev_stations_screen.dart
import 'package:flutter/material.dart';
import 'package:geolocator_android/geolocator_android.dart';
import '../models/ev_station_model.dart';
import '../services/ev_station_service.dart';
import 'ev_station_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EVStationsScreen extends StatefulWidget {
  const EVStationsScreen({Key? key}) : super(key: key);

  @override
  State<EVStationsScreen> createState() => _EVStationsScreenState();
}

class _EVStationsScreenState extends State<EVStationsScreen> {
  final EVStationService _stationService = EVStationService();
  final GeolocatorAndroid _geolocator = GeolocatorAndroid();
  double? _userLatitude;
  double? _userLongitude;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await _geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Check location permissions
      LocationPermission permission = await _geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Get current position
      Position position = await _geolocator.getCurrentPosition();
      setState(() {
        _userLatitude = position.latitude;
        _userLongitude = position.longitude;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _openMapsNavigation(EVStation station) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${station.latitude},${station.longitude}';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch navigation')),
      );
    }
  }

  String _calculateDistance(EVStation station) {
    if (_userLatitude == null || _userLongitude == null) {
      return 'Unknown distance';
    }

    double distanceInMeters = _geolocator.distanceBetween(
      _userLatitude!,
      _userLongitude!,
      station.latitude,
      station.longitude,
    );

    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(0)} m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Charging Stations'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<EVStation>>(
        stream: _stationService.getEVStations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final stations = snapshot.data ?? [];

          if (stations.isEmpty) {
            return const Center(child: Text('No EV stations available'));
          }

          // Sort stations by distance if user location is available
          if (_userLatitude != null && _userLongitude != null) {
            stations.sort((a, b) {
              double distanceA = _geolocator.distanceBetween(
                _userLatitude!,
                _userLongitude!,
                a.latitude,
                a.longitude,
              );

              double distanceB = _geolocator.distanceBetween(
                _userLatitude!,
                _userLongitude!,
                b.latitude,
                b.longitude,
              );

              return distanceA.compareTo(distanceB);
            });
          }

          return ListView.builder(
            itemCount: stations.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final station = stations[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        station.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(station.address),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: station.isAvailable ? Colors.green.shade100 : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          station.isAvailable ? 'Available' : 'Unavailable',
                          style: TextStyle(
                            color: station.isAvailable ? Colors.green.shade800 : Colors.red.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (_userLatitude != null && _userLongitude != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Distance: ${_calculateDistance(station)}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 8,
                        children: station.connectorTypes.map((type) =>
                            Chip(
                              label: Text(type),
                              backgroundColor: Colors.blue.shade100,
                            )
                        ).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.info_outline),
                            label: const Text('Details'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EVStationDetailScreen(station: station),
                                ),
                              );
                            },
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.directions),
                            label: const Text('Navigate'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () => _openMapsNavigation(station),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
