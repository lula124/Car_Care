// screens/booking_calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/service_station_model.dart';
import '../models/vehicle_model.dart';
import '../services/booking_service.dart';
import '../services/vehicle_service.dart';
import '../services/auth_service.dart';
import 'booking_confirmation_screen.dart';

class BookingCalendarScreen extends StatefulWidget {
  final ServiceStation station;

  const BookingCalendarScreen({Key? key, required this.station}) : super(key: key);

  @override
  State<BookingCalendarScreen> createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
  final BookingService _bookingService = BookingService();
  final VehicleService _vehicleService = VehicleService();
  final AuthService _authService = AuthService();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String> _availableTimeSlots = [];
  String? _selectedTimeSlot;
  Vehicle? _selectedVehicle;
  List<Vehicle> _userVehicles = [];
  String _selectedServiceType = 'Service'; // Default service type
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadUserVehicles();
    _loadAvailableSlots();
  }

  Future<void> _loadUserVehicles() async {
    final userId = _authService.currentUser?.uid;
    if (userId == null) return;

    _vehicleService.getUserVehicles(userId).listen((vehicles) {
      if (mounted) {
        setState(() {
          _userVehicles = vehicles;
          if (vehicles.isNotEmpty) {
            _selectedVehicle = vehicles.first;
          }
        });
      }
    });
  }

  Future<void> _loadAvailableSlots() async {
    if (_selectedDay == null) return;

    setState(() {
      _isLoading = true;
      _selectedTimeSlot = null;
    });

    try {
      final slots = await _bookingService.getAvailableTimeSlots(
        widget.station.id,
        _selectedDay!,
      );

      if (mounted) {
        setState(() {
          _availableTimeSlots = slots;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading time slots: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book at ${widget.station.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 30)),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedTimeSlot = null;
                    });
                    _loadAvailableSlots();
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Vehicle selection
            const Text(
              'Select Vehicle:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_userVehicles.isEmpty)
              const Text('No vehicles found. Please add a vehicle first.')
            else
              DropdownButtonFormField<Vehicle>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                value: _selectedVehicle,
                items: _userVehicles.map((vehicle) {
                  return DropdownMenuItem<Vehicle>(
                    value: vehicle,
                    child: Text('${vehicle.make} ${vehicle.model} (${vehicle.year})'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedVehicle = value;
                  });
                },
              ),

            const SizedBox(height: 20),

            // Service type selection
            const Text(
              'Service Type:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              value: _selectedServiceType,
              items: ['Service', 'Repair', 'Maintenance', 'Other'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedServiceType = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // Time slots
            const Text(
              'Available Time Slots:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_availableTimeSlots.isEmpty)
              const Text('No available time slots for the selected date.')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableTimeSlots.map((slot) {
                  final isSelected = _selectedTimeSlot == slot;
                  return ChoiceChip(
                    label: Text(slot),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedTimeSlot = selected ? slot : null;
                      });
                    },
                  );
                }).toList(),
              ),

            const SizedBox(height: 30),

            // Book button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedVehicle != null && _selectedTimeSlot != null)
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingConfirmationScreen(
                        station: widget.station,
                        vehicle: _selectedVehicle!,
                        date: _selectedDay!,
                        timeSlot: _selectedTimeSlot!,
                        serviceType: _selectedServiceType,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Continue to Booking', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
