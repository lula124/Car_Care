import 'package:flutter/material.dart';

class VehicleRegistrationPage extends StatefulWidget {
  @override
  _VehicleRegistrationPageState createState() => _VehicleRegistrationPageState();
}

class _VehicleRegistrationPageState extends State<VehicleRegistrationPage> {
  int currentStep = 0;

  // Controllers
  final vehicleNumberController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final colorController = TextEditingController();

  final chassisNumberController = TextEditingController();
  final engineNumberController = TextEditingController();

  final ownerNameController = TextEditingController();
  final contactNumberController = TextEditingController();

  String? selectedTransmission;
  String? selectedFuelType;

  void nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void submitForm() {
    // You can handle saving or validation here
    print("Vehicle Registered");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Registration", 
        style: TextStyle(color: Color(0xFFF5F5F5),
        fontSize: 25, fontWeight: FontWeight.w500),),
        backgroundColor: const Color(0xFF252525),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: currentStep,
                  children: [
                    buildStep1(),
                    buildStep2(),
                    buildStep3(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 0)
                    ElevatedButton(
                      onPressed: previousStep,
                      child: Text("Back"),
                      style: buttonStyle(),
                    ),
                  ElevatedButton(
                    onPressed: currentStep == 2 ? submitForm : nextStep,
                    child: Text(currentStep == 2 ? "Submit" : "Next"),
                    style: buttonStyle(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStep1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTextField(vehicleNumberController, "Vehicle Number"),
          buildTextField(brandController, "Brand"),
          buildTextField(modelController, "Model"),
          buildTextField(yearController, "Year"),
          buildTextField(colorController, "Color"),
        ],
      ),
    );
  }

  Widget buildStep2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildDropdown(
            "Transmission",
            ["Automatic", "Manual"],
            selectedTransmission,
            (val) => setState(() => selectedTransmission = val),
          ),
          buildDropdown(
            "Fuel Type",
            ["Petrol", "Diesel", "Electric", "Hybrid"],
            selectedFuelType,
            (val) => setState(() => selectedFuelType = val),
          ),
          buildTextField(chassisNumberController, "Chassis Number"),
          buildTextField(engineNumberController, "Engine Number"),
        ],
      ),
    );
  }

  Widget buildStep3() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTextField(ownerNameController, "Owner Name"),
          buildTextField(contactNumberController, "Contact Number"),
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(width: 2.5, color: Color(0xFF252525)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(width: 3, color: Color(0xFF252525)),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, List<String> options, String? value, Function(String?) onChanged) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF252525), width: 2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(label),
          value: value,
          isExpanded: true,
          onChanged: onChanged,
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ),
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Color(0XFFFFC107),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
