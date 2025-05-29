import 'package:flutter/material.dart';

class UpdateServiceRecord extends StatefulWidget {
  const UpdateServiceRecord({super.key});

  @override
  State<UpdateServiceRecord> createState() => _UpdateServiceRecordPageState();
}

class _UpdateServiceRecordPageState extends State<UpdateServiceRecord> {
  int currentStep = 0;

  // Step 1: Mileage
  final TextEditingController mileageController = TextEditingController();

  // Step 2: Maintenance Checkboxes
  final Map<String, bool> maintenanceChecks = {
    "Engine Oil Change": false,
    "Brake Oil Change": false,
    "Air Filter Replacement": false,
    "Coolant Refill": false,
    "Battery Check": false,
    "Spark Plug Replacement": false,
    "Transmission Oil Check": false,
    "Tire Pressure Check": false,
  };

  // Step 3: Additional Repairs
  final TextEditingController repairTypeController = TextEditingController();
  final TextEditingController repairNoteController = TextEditingController();

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
    String mileage = mileageController.text;
    Map<String, bool> selectedServices = Map.from(maintenanceChecks)
      ..removeWhere((key, value) => !value);

    String repairType = repairTypeController.text;
    String note = repairNoteController.text;

    print("Mileage: $mileage");
    print("Selected Maintenance: $selectedServices");
    print("Repair Type: $repairType");
    print("Note: $note");

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Service Record Submitted"),
    ));
  }

//111111111111111111111111111111111111111111111111111111111

Widget buildMileageStep() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Text(
          "Current Mileage",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      Text(
        "Enter the current odometer reading in kilometers",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Container(
        width: 250,
        padding: EdgeInsets.only(top: 25, bottom: 20),
        child: TextField(
          controller: mileageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Current Mileage",
            hintStyle: TextStyle(fontSize: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                width: 2.5,
                color: Color(0xFF252525),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                width: 3,
                color: Color(0xFF252525),
              ),
            ),
            // Optional: Replace with suitable icon
          ),
        ),
      ),
      Container(
        width: 120,
        height: 50,
        padding: EdgeInsets.only(top: 0),
        child: ElevatedButton(
          onPressed: nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0XFFFFC107),
            foregroundColor: Color(0xFF252525),
            textStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xFF252525),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text("Next"),
        ),
      ),
    ],
  );
}

// 22222222222222222222222222222222222222222222222222222222222222222222222222

  Widget buildMaintenanceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.only(bottom: 10, top:10),
          child: Text("Regular Maintenance", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, )),
        )),
        SizedBox(height: 20,),
        ...maintenanceChecks.keys.map((key) {
          return CheckboxListTile(
  title: Text(
    key,
    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
  ),
  value: maintenanceChecks[key],
  onChanged: (val) {
    setState(() {
      maintenanceChecks[key] = val!;
    });
  },
  dense: true, // Reduces vertical space
  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: -4),
  activeColor: Colors.black, // Make checkbox black when selected
  checkColor: Colors.white,  // Optional: checkbox tick color
);
        }).toList(),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 50,
              child: ElevatedButton(onPressed: previousStep,
              style: ElevatedButton.styleFrom(backgroundColor: Color(0XFFFFC107)),
               child: Text("Back", style: TextStyle(fontSize: 22, color: Color(0xFF252525), fontWeight: FontWeight.w500),)),
            ),
            SizedBox(width: 70),
            Container(
              height: 50,
              width: 120,
              child: ElevatedButton(onPressed: nextStep,
              style: ElevatedButton.styleFrom(backgroundColor: Color(0XFFFFC107)),
               child: Text("Next", style: TextStyle(fontSize: 22, color: Color(0xFF252525), fontWeight: FontWeight.w500),)),
            ),
          ],
        )
      ],
    );
  }

//33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

  Widget buildAdditionalRepairsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text("Special Repairs", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
        )),
        SizedBox(height: 20),
        TextField(
          controller: repairTypeController,
          decoration: InputDecoration(labelText: "Repair Type", border: OutlineInputBorder()),
        ),
        SizedBox(height: 15),
        TextField(
          controller: repairNoteController,
          maxLines: 4,
          decoration: InputDecoration(labelText: "Note", border: OutlineInputBorder()),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: previousStep, child: Text("Back", style: TextStyle(fontSize: 24, color: Color(0xFF252525), fontWeight: FontWeight.bold),)),
            SizedBox(width: 80,),
            ElevatedButton(onPressed: submitForm, child: Text("Submit",  style: TextStyle(fontSize: 24, color: Color(0xFF252525), fontWeight: FontWeight.bold),)),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
  preferredSize: Size.fromHeight(65),
  child: AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(top: 8, left: 5),
      child: IconButton(
        icon: Icon(Icons.arrow_back, size: 38, color: Color(0xFFFFC107)),
        onPressed: () {
          // Navigate back
        },
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(top: 15, left: 0),
      child: Text(
        "Update Service Record",
        style: TextStyle(
          color: Color(0xFFF5F5F5),
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    backgroundColor: Color(0xFF252525),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 6, right: 15),
        child: PopupMenuButton<String>(
          icon: Icon(Icons.menu, size: 40, color: Color(0xFFFFC107)),
          onSelected: (value) {
            if (value == 'logout') {
              // Handle logout logic here
              print('User logged out');
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'logout',
              child: Text('Logout', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    ],
  ),
),
      body: Padding(
  padding: const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 30),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: IndexedStack(
          index: currentStep,
          children: [
            buildMileageStep(),
            buildMaintenanceStep(),
            buildAdditionalRepairsStep(),
          ],
        ),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentStep >= index
                  ? Color(0xFFFFC107) // Active/completed step
                  : Colors.grey.shade400, // Inactive step
            ),
          );
        }),
      ),
    ],
  ),
),

    );
  }
}
