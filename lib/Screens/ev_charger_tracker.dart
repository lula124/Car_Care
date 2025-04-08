import 'package:flutter/material.dart';

void main() => runApp(EVChargingApp());

class EVChargingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChargingHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChargingHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV Charging Tracker'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ev_station), label: 'Station'),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Charging'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Searching Charging Station...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text('Nearby Charging Station'),
                subtitle: Text('4 Stations Within 10Km'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.battery_charging_full, color: Colors.blue),
                title: Text('Charging Status'),
                subtitle: Text('Station A3 - Charging in Progress'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.book_online),
                  label: Text("Book Slot"),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.payment),
                  label: Text("Payment"),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.history),
                  label: Text("Charging History"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Recently Shows...", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ChargingStationTile(
              name: "Green Power Station",
              distance: "2.3 Km",
              slots: "5 Slots",
              price: "Rs.23 / KWh",
              rating: "4.8",
            ),
            ChargingStationTile(
              name: "Jagath Charging Center",
              distance: "1.3 Km",
              slots: "2 Slots",
              price: "Rs.28 / KWh",
              rating: "5.3",
            ),
          ],
        ),
      ),
    );
  }
}

class ChargingStationTile extends StatelessWidget {
  final String name;
  final String distance;
  final String slots;
  final String price;
  final String rating;

  ChargingStationTile({
    required this.name,
    required this.distance,
    required this.slots,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Icon(Icons.ev_station, color: Colors.green),
            SizedBox(width: 8),
            Expanded(child: Text(name, style: TextStyle(fontWeight: FontWeight.bold))),
            Icon(Icons.star, color: Colors.yellow, size: 20),
            Text(rating),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$distance | $slots | $price'),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.navigation),
              label: Text('Direction'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
