// screens/emergency_sos_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencySOSScreen extends StatefulWidget {
  const EmergencySOSScreen({Key? key}) : super(key: key);

  @override
  State<EmergencySOSScreen> createState() => _EmergencySOSScreenState();
}

class _EmergencySOSScreenState extends State<EmergencySOSScreen> {
  bool _isStreaming = false;

  Future<void> _callEmergencyNumber(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $number')),
      );
    }
  }

  void _toggleLiveStream() {
    setState(() {
      _isStreaming = !_isStreaming;
    });

    if (_isStreaming) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Live streaming started. Help is on the way!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency SOS'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red),
              ),
              child: Column(
                children: [
                  const Text(
                    'EMERGENCY SOS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Press the button below to send an emergency alert with your location',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: const CircleBorder(),
                      ),
                      onPressed: _toggleLiveStream,
                      child: Icon(
                        _isStreaming ? Icons.emergency_recording : Icons.emergency,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _isStreaming ? 'STREAMING LIVE' : 'PRESS FOR HELP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isStreaming ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildEmergencyContactCard(
              'Police',
              '911',
              Icons.local_police,
              Colors.blue,
            ),
            _buildEmergencyContactCard(
              'Ambulance',
              '911',
              Icons.local_hospital,
              Colors.green,
            ),
            _buildEmergencyContactCard(
              'Fire Department',
              '911',
              Icons.fire_truck,
              Colors.orange,
            ),
            _buildEmergencyContactCard(
              'Roadside Assistance',
              '1-800-222-4357',
              Icons.car_repair,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactCard(
      String title,
      String number,
      IconData icon,
      Color color,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(number),
        trailing: IconButton(
          icon: const Icon(Icons.call),
          color: Colors.green,
          onPressed: () => _callEmergencyNumber(number),
        ),
      ),
    );
  }
}
