import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedLocation;
  String? selectedType;
  String? selectedImage;

  final List<String> locations = ['City A', 'City B', 'City C'];
  final List<String> types = ['Fuel/EV', 'Electric', 'Hybrid'];
  final List<String> images = ['Image1.png', 'Image2.png'];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController batteryController = TextEditingController();

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    numberController.clear();
    modelController.clear();
    mileageController.clear();
    batteryController.clear();
    setState(() {
      selectedLocation = null;
      selectedType = null;
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Here'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Name', nameController),
              buildTextField('Phone Number', phoneController, keyboardType: TextInputType.phone),
              buildDropdownField('Location', locations, selectedLocation, (value) {
                setState(() {
                  selectedLocation = value;
                });
              }),
              const SizedBox(height: 20),
              const Text('Vehicle Details:', style: TextStyle(fontWeight: FontWeight.bold)),
              buildTextField('Number', numberController),
              buildTextField('Model', modelController),
              buildDropdownField('Type', types, selectedType, (value) {
                setState(() {
                  selectedType = value;
                });
              }),
              buildTextField('Mileage', mileageController),
              buildTextField('Battery Capacity', batteryController),
              buildDropdownField('Images', images, selectedImage, (value) {
                setState(() {
                  selectedImage = value;
                });
              }),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: clearForm,
                      child: const Text('Clear'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle registration logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registered Successfully')),
                          );
                        }
                      },
                      child: const Text('Register'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ev_station), label: 'Station'),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Charging'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedItem,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
