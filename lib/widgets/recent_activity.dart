import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        SizedBox( // Constrained SizedBox
          height: MediaQuery.of(context).size.height * 0.3, // 30% of screen height (adjust as needed)
          child: ListView.builder(
            itemCount: recentActivities.length,
            itemBuilder: (context, index) {
              final item = recentActivities[index];
              return RecentActivityItemTile(item: item); // Use a custom ListTile widget
            },
          ),
        ),
      ],
    );
  }
}

// Custom ListTile widget for Recent Activity items
class RecentActivityItemTile extends StatelessWidget {
  final RecentActivityItem item;

  const RecentActivityItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(item.subtitle, style: Theme.of(context).textTheme.bodySmall),
      onTap: item.onTap, // Pass the onTap function directly
    );
  }
}


// Model for Recent Activity items (keep in the same file or move to models directory)
class RecentActivityItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;  // Optional onTap callback

  RecentActivityItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap, //Optional onTap
  });
}


// Sample Recent Activity Data (Replace with your actual data)

final List<RecentActivityItem> recentActivities = [
  RecentActivityItem(
    title: 'Order #12345 - Customer: John Doe',
    subtitle: 'Status: Pending, Total: \$150',
    icon: Icons.shopping_bag,
    onTap: () {
      // TODO: Add navigation logic here, e.g., using GoRouter
      // Example: context.goNamed('orderDetails', params: {'orderId': '12345'});
      print('Tapped on Order #12345');
    },

  ),

  // ... more RecentActivityItem instances
];