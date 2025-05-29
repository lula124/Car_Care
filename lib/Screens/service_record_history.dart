import 'package:flutter/material.dart';

class ServiceHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> serviceRecords = [
    {
      "date": "2025/01/01",
      "mileage": 23300,
      "regularMaintenance": [
        "Engine Oil Change",
        "Brake Oil Change",
        "Air Filter Replacement"
      ],
      "specialRepair": {
        "type": "Engine Repair",
        "note":
            "Rats damaged radiator fan wires. Fan not working, engine overheated and damaged gascut."
      }
    },
    {
      "date": "2025/03/10",
      "mileage": 27000,
      "regularMaintenance": ["Coolant Top-up", "Tire Rotation"],
      "specialRepair": {
        "type": "Electrical",
        "note": "Battery terminal corroded and cleaned."
      }
    },
    {
      "date": "2025/05/05",
      "mileage": 30000,
      "regularMaintenance": [
        "Engine Oil Change",
        "AC Filter Replacement",
        "Brake Pad Check"
      ],
      "specialRepair": {"type": null, "note": null}
    },
    {
      "date": "2025/07/20",
      "mileage": 33500,
      "regularMaintenance": ["Spark Plug Replacement"],
      "specialRepair": {
        "type": "Suspension Repair",
        "note": "Front shocks replaced due to wear."
      }
    },
    {
      "date": "2025/09/15",
      "mileage": 36000,
      "regularMaintenance": [
        "Air Filter Replacement",
        "Engine Oil Change",
      ],
      "specialRepair": {
        "type": "Paint Touch-up",
        "note": "Minor scratches repainted on rear bumper."
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service History"),
        backgroundColor: Color(0xFF252525),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: serviceRecords.length,
        itemBuilder: (context, index) {
          final record = serviceRecords[index];
          return buildServiceCard(record);
        },
      ),
    );
  }

  Widget buildServiceCard(Map<String, dynamic> record) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Service Date: ${record['date']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text("Mileage: ${record['mileage']} km",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text("Regular Maintenance:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal)),
            ...List.generate(record['regularMaintenance'].length, (i) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, size: 16, color: Colors.teal),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(record['regularMaintenance'][i],
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              );
            }),
            if (record['specialRepair']?['type'] != null) ...[
              SizedBox(height: 12),
              Text("Special Repair:",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent)),
              SizedBox(height: 4),
              Text("Type: ${record['specialRepair']['type']}",
                  style: TextStyle(fontSize: 15)),
              if (record['specialRepair']['note'] != null) ...[
                SizedBox(height: 4),
                Text("Note: ${record['specialRepair']['note']}",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
              ]
            ]
          ],
        ),
      ),
    );
  }
}
