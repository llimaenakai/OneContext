import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ... (Overview Text and SizedBox)

        GridView.count(
          crossAxisCount: 2, // Set a value for crossAxisCount (e.g., 2 for a 2x2 grid)
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1.2, // Adjust as needed
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            // ... (Your DashboardCard widgets)
          ],
        ),

        // ... (other dashboard sections)
      ],
    );
  }
}