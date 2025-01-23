import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesoftware/widgets/dashboard.dart';  // Import your Dashboard widget
import 'package:mobilesoftware/widgets/recent_activity.dart'; // Import RecentActivity Widget (Create this new widget as shown below)



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 
          'Home',

          style: Theme.of(context).textTheme.titleLarge, // Use a theme text style
        ),
        centerTitle: true, // Center the title
        actions: [
          // ... (search and other actions)
        ],
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Dashboard(),
              const SizedBox(height: 32),
              const RecentActivity(),
              // ... Add other sections here
            ],
          ),
        ),
      ),
    );
  }

  // Separate function for building the Drawer
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader( //Use const where possible.
            decoration: BoxDecoration(
              color: Colors.blue, // Or use your theme's primary color
            ),
            child: Center(
              child: Text(
                'Mobile Shop',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              // context.goNamed('dashboard');  // Handle navigation as before
            },
          ),
          const Divider(),
          // ... Other drawer items
        ],
      ),
    );
  }

}