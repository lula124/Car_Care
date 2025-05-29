import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Vehicle", style: TextStyle(color: Colors.white)),
            Text("Good Morning, John Doe",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              runApp(MaterialApp(home: newPage("Notification Page")));
            },
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text("PP", style: TextStyle(color: Colors.black)),
          ),
          SizedBox(width: 10),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          String page = "";
          if (index == 0) page = "Station Page";
          if (index == 1) page = "Charging Page";
          if (index == 2) page = "Billing Page";
          if (index == 3) page = "Notification Page";

          if (page.isNotEmpty) {
            runApp(MaterialApp(home: newPage(page)));
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ev_station, color: Colors.black, weight: 900),
            label: "Station",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_charging_full,
                color: Colors.black, weight: 900),
            label: "Charging",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long, color: Colors.black),
            label: "Billing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.black),
            label: "Notification",
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("HONDA FIT SHUTTLE",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("CAW-3287"),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("65,890 KM"),
                      ElevatedButton(
                        onPressed: () {
                          runApp(MaterialApp(home: newPage("Vehicle Details")));
                        },
                        child: Text("View Details"),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    runApp(MaterialApp(home: newPage("SOS Page")));
                  },
                  child: Text("SOS", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    runApp(MaterialApp(home: newPage("Maintenance Page")));
                  },
                  child: Icon(Icons.build),
                ),
                ElevatedButton(
                  onPressed: () {
                    runApp(MaterialApp(home: newPage("Explore Page")));
                  },
                  child: Icon(Icons.explore),
                ),
                ElevatedButton(
                  onPressed: () {
                    runApp(MaterialApp(home: newPage("Warning Page")));
                  },
                  child: Icon(Icons.warning),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.build),
                      SizedBox(width: 5),
                      Text(
                        "Engine Oil Replacement Due",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Schedule in 70,000 KM",
                          style: TextStyle(color: Colors.grey)),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          runApp(MaterialApp(
                              home: newPage("Maintenance Schedule")));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Service Records"),
                  TextButton(
                    onPressed: () {
                      runApp(MaterialApp(home: newPage("Service Report")));
                    },
                    child: Text("View Report"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}

// Function to create new pages
Widget newPage(String pageName) {
  return Scaffold(
    appBar: AppBar(title: Text(pageName)),
    body: Center(child: Text("Welcome to $pageName")),
  );
}
