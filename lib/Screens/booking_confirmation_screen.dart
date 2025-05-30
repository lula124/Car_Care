// screens/booking_confirmation_screen.dart
import 'package:flutter/material.dart';
import '../models/service_booking_model.dart';
import '../models/service_station_model.dart';
import '../models/vehicle_model.dart';
import '../services/booking_service.dart';
import '../services/auth_service.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final ServiceStation station;
  final Vehicle vehicle;
  final DateTime date;
  final String timeSlot;
  final String serviceType;

  const BookingConfirmationScreen({
    Key? key,
    required this.station,
    required this.vehicle,
    required this.date,
    required this.timeSlot,
    required this.serviceType,
  }) : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  final BookingService _bookingService = BookingService();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _confirmBooking() async {
    final userId = _authService.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to book')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final booking = ServiceBooking(
        id: '',
        userId: userId,
        vehicleId: widget.vehicle.id,
        serviceType: widget.serviceType,
        bookingDate: widget.date,
        timeSlot: widget.timeSlot,
        serviceStationId: widget.station.id,
        serviceStationName: widget.station.name,
      );

      await _bookingService.createBooking(booking);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking confirmed successfully!')),
      );

      // Navigate back to home screen
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error confirming booking: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Station: ${widget.station.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Address: ${widget.station.address}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Service Type: ${widget.serviceType}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: ${widget.date.day}/${widget.date.month}/${widget.date.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Time: ${widget.timeSlot}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Vehicle: ${widget.vehicle.make} ${widget.vehicle.model} (${widget.vehicle.year})',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'License Plate: ${widget.vehicle.licensePlate}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _confirmBooking,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Confirm Booking', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
