import 'package:flutter/material.dart';

void main() {
  runApp(ServiceReminderApp());
}

class ServiceReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ServiceReminderScreen(),
    );
  }
}

class ServiceReminderScreen extends StatefulWidget {
  @override
  _ServiceReminderScreenState createState() => _ServiceReminderScreenState();
}

class _ServiceReminderScreenState extends State<ServiceReminderScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> reminders = [
    {
      "title": "Tyre Replacement Due",
      "due": "500 km",
      "recommended": "Within 7 days"
    },
    {
      "title": "Battery Check",
      "due": "1500 km",
      "recommended": "Within 15 days"
    },
    {
      "title": "Charging Port Service",
      "due": "3000 km",
      "recommended": "Within 30 days"
    },
    {
      "title": "Engine Oil Replacement",
      "due": "500 km",
      "recommended": "Within 7 days"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Service Reminders",
          style: TextStyle(
            color: Colors.white, // White color text
            fontWeight: FontWeight.bold, // Bold text
            fontSize: 20, // Optional: Increase size if needed
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10), // Space between navigation bar and white box
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white, // Outer white box
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 184, 193, 200), // Inner blue box
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HONDA FIT SHUTTLE",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 25, 24, 24)),
                  ),
                  SizedBox(height: 5),
                  Text("CAW-3287", style: TextStyle(color: const Color.fromARGB(255, 14, 14, 14))),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Current Mileage : 29 500 km",
                      style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 18, 18, 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white, // Outer white box
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminders[index]['title'],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height:2 ),
                        // White box inside with reminder details
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 154, 198, 245), // Outer white box
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Due in: ${reminders[index]['due']}",
                                style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 14, 14, 14)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Recommended: ${reminders[index]['recommended']}",
                                style: TextStyle(color: const Color.fromARGB(255, 17, 17, 17)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                            child: Text("Book"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300], // Set background color to gray
        selectedItemColor: Colors.black, // Selected icon color is black
        unselectedItemColor: Colors.black, // Unselected icon color is also black
        showUnselectedLabels: true, // Ensures labels always show
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: "Station",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_charging_full),
            label: "Charging",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Billing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),
        ],
      ),
    );
  }
}
