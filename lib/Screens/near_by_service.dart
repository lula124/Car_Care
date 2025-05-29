import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChargingStationsScreen(),
  ));
}

class ChargingStationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              "Nearest Charging Stations",
              style: TextStyle(
                color: Colors.white, // Text color changed to white
                fontWeight: FontWeight.bold, // Made the text bold
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          stationCard(context, "Green Power Station", "2.3 Km", "5 Slots",
              "Rs.23 / KWh", 4.8),
          stationCard(context, "Jagath Charging Center", "1.3 Km", "2 Slots",
              "Rs.28 / KWh", 5.3),
          stationCard(context, "Super Power Station", "2.4 Km", "6 Slots",
              "Rs.22 / KWh", 4.8),
          stationCard(context, "N&N Power Station", "1.8 Km", "10 Slots",
              "Rs.27 / KWh", 4.8),
          stationCard(context, "Mahinda Power Station", "2.8 Km", "15 Slots",
              "Rs.33 / KWh", 4.8),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StationPage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChargingPage()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BillingPage()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
              break;
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
    );
  }
}

Widget stationCard(BuildContext context, String name, String distance,
    String slots, String price, double rating) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.bolt,
                      color: Colors.blue, size: 18), // Thunder Icon
                  SizedBox(width: 6),
                  Text(name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 5),
                  Text(rating.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowIconText(Icons.location_on, distance),
              rowIconText(Icons.ev_station, slots),
              rowIconText(Icons.attach_money, price),
            ],
          ),
          SizedBox(height: 10),
          Center(
              child: SizedBox(
            width: 250, // Adjust the width as needed
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DirectionPage()));
              },
              child: Text("Direction", style: TextStyle(color: Colors.white)),
            ),
          )),
        ],
      ),
    ),
  );
}

Widget rowIconText(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 18, color: Colors.blue), // Changed icon color to blue
      SizedBox(width: 5),
      Text(text,
          style: TextStyle(color: Colors.blue)), // Changed text color to blue
    ],
  );
}

class StationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Station Page")),
        body: Center(child: Text("Station Details")));
  }
}

class ChargingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Charging Page")),
        body: Center(child: Text("Charging Details")));
  }
}

class BillingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Billing Page")),
        body: Center(child: Text("Billing Details")));
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notification Page")),
        body: Center(child: Text("Notifications")));
  }
}

class DirectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Direction Page")),
        body: Center(child: Text("Directions")));
  }
}
