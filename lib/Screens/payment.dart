import 'package:flutter/material.dart';

void main() {
  runApp(PaymentManagementApp());
}

class PaymentManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentManagementScreen(),
    );
  }
}

class PaymentManagementScreen extends StatefulWidget {
  @override
  _PaymentManagementScreenState createState() => _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Payment Management",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {},
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 20), // Space below navigation bar
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        "Payment Methods",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: Colors.blue),
                        label: Text("Add Card", style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildCardItem("Visa *****4531", "Expired 12/25", true),
                  SizedBox(height: 10),
                  _buildCardItem("Visa *****4143", "Expired 01/29", false),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300], // Gray background
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.place, color: Colors.black), label: "Station"),
          BottomNavigationBarItem(icon: Icon(Icons.battery_charging_full, color: Colors.black), label: "Charging"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt, color: Colors.black), label: "Billing"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications, color: Colors.black), label: "Notification"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, 
        unselectedItemColor: Colors.black, 
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCardItem(String cardNumber, String expiry, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green[100] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? Colors.green : Colors.grey, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardNumber,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 3),
              Text(expiry, style: TextStyle(color: Colors.grey[700])),
            ],
          ),
          Icon(isSelected ? Icons.check_circle : Icons.delete, color: isSelected ? Colors.green : Colors.red),
        ],
      ),
    );
  }
}
