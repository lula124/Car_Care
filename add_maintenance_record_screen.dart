// screens/add_maintenance_record_screen.dart
import 'package:flutter/material.dart';
import '../services/maintenance_service.dart';
import '../services/vehicle_service.dart';
import '../models/vehicle_model.dart';

class AddMaintenanceRecordScreen extends StatefulWidget {
  final String vehicleId;
  final int currentMileage; // Add current mileage parameter

  const AddMaintenanceRecordScreen({
    Key? key,
    required this.vehicleId,
    required this.currentMileage, // Require current mileage
  }) : super(key: key);

  @override
  State<AddMaintenanceRecordScreen> createState() => _AddMaintenanceRecordScreenState();
}

class _AddMaintenanceRecordScreenState extends State<AddMaintenanceRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final VehicleService _vehicleService = VehicleService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill the mileage field with current vehicle mileage
    _mileageController.text = widget.currentMileage.toString();
  }

  @override
  void dispose() {
    _typeController.dispose();
    _mileageController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final mileage = int.parse(_mileageController.text.trim());
        final type = _typeController.text.trim();
        final date = _dateController.text.trim();
        final notes = _notesController.text.trim();

        // Add the maintenance record
        await MaintenanceService().addMaintenanceRecord(
          vehicleId: widget.vehicleId,
          type: type,
          mileage: mileage,
          date: date,
          notes: notes,
        );

        // Update the vehicle's mileage if the new mileage is higher
        if (mileage > widget.currentMileage) {
          await _vehicleService.updateVehicleMileage(widget.vehicleId, mileage);
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maintenance record added successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Maintenance Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Type dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Record Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Maintenance', child: Text('Maintenance')),
                  DropdownMenuItem(value: 'Repair', child: Text('Repair')),
                  DropdownMenuItem(value: 'Service', child: Text('Service')),
                ],
                onChanged: (value) {
                  _typeController.text = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a record type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mileage field
              TextFormField(
                controller: _mileageController,
                decoration: const InputDecoration(
                  labelText: 'Current Mileage (km)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the current mileage';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }

                  // Validate that the new mileage is not less than the current vehicle mileage
                  final newMileage = int.parse(value);
                  if (newMileage < widget.currentMileage) {
                    return 'Mileage cannot be less than the current vehicle mileage (${widget.currentMileage} km)';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date field with picker
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _selectDate,
                  ),
                ),
                readOnly: true,
                onTap: _selectDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Notes field
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                  hintText: 'Enter details about the work done',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Add Record', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
