import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement Search functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Mobile Shop'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                // Navigate to Dashboard
              },
            ),
            ListTile(
              title: Text('Customers'),
              onTap: () {
                // Navigate to Customers screen
              },
            ),
            ListTile(
              title: Text('Orders'),
              onTap: () {
                // Navigate to Orders screen
              },
            ),
            ListTile(
              title: Text('Items'),
              onTap: () {
                // Navigate to Items screen
              },
            ),
            ListTile(
              title: Text('Vendors'),
              onTap: () {
                // Navigate to Vendors screen
              },
            ),
            ListTile(
              title: Text('Payments'),
              onTap: () {
                // Navigate to Payments screen
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings screen
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Summary Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardCard(title: 'Total Customers', count: 120),
                  DashboardCard(title: 'Total Orders', count: 300),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardCard(title: 'Pending Invoices', count: 15),
                  DashboardCard(title: 'Total Payments', count: 250),
                ],
              ),
              SizedBox(height: 20),

              // Recent Activity Section
              Text(
                'Recent Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Order #12345 - Customer: John Doe'),
                subtitle: Text('Status: Pending, Total: \$150'),
                onTap: () {
                  // Navigate to specific Order details screen
                },
              ),
              ListTile(
                title: Text('Invoice #23456 - Customer: Jane Doe'),
                subtitle: Text('Status: Paid, Total: \$200'),
                onTap: () {
                  // Navigate to specific Invoice details screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final int count;

  const DashboardCard({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 24,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
