import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ServiceRecordScreen(),
    );
  }
}

class ServiceRecordScreen extends StatelessWidget {
  final List<Map<String, String>> serviceRecords = [
    {
      "title": "Regular Maintain",
      "date": "01 Jan 2024",
      "mileage": "10,000 Km"
    },
    {"title": "Battery Check", "date": "01 Jan 2024", "mileage": "10,000 Km"},
    {"title": "Tyre Replace", "date": "01 Jan 2024", "mileage": "10,000 Km"},
    {
      "title": "Regular Maintain",
      "date": "01 Jan 2024",
      "mileage": "10,000 Km"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Records"),
        backgroundColor: Colors.blue,
        leading: Icon(Icons.arrow_back),
        actions: [Icon(Icons.notifications)],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: serviceRecords.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(serviceRecords[index]["title"]!),
                    subtitle: Text(
                      "Date: ${serviceRecords[index]["date"]}\nMileage: ${serviceRecords[index]["mileage"]}",
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: Text("View Details"),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text("Download PDF", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Station"),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: "Charging"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Billing"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notification"),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
