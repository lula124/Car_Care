import 'package:flutter/material.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Billing'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Current Month Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total Cost\nRs. 8230'),
                        Text('Total Energy\n156 kW'),
                        Text('Avg. Cost/Charge\nRs. 45'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Billing History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildBillingItem('January 2024', 'Rs. 8300'),
                  _buildBillingItem('December 2023', 'Rs. 10300'),
                  _buildBillingItem('November 2023', 'Rs. 9200'),
                  _buildBillingItem('October 2023', 'Rs. 11900'),
                  _buildBillingItem('September 2023', 'Rs. 6450'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingItem(String month, String amount) {
    return ListTile(
      title: Text(month),
      trailing: Text(amount, style: const TextStyle(color: Colors.blue)),
    );
  }
}
