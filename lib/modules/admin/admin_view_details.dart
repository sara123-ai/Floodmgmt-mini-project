import 'package:flutter/material.dart';

// A summary view for the admin
class AdminViewDetails extends StatelessWidget {
  const AdminViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Details")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Camps:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text("Camp A - Location 1, Capacity: 100"),
            Text("Camp B - Location 2, Capacity: 150"),
            SizedBox(height: 20),
            Text(
              "Quick Response Teams (QRTs):",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text("Team Alpha - Zone 1, Members: 10"),
            Text("Team Beta - Zone 2, Members: 8"),
            SizedBox(height: 20),
            Text(
              "Members:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text("John Doe - Admin, Contact: 1234567890"),
            Text("Jane Smith - Camp Manager, Contact: 0987654321"),
          ],
        ),
      ),
    );
  }
}
