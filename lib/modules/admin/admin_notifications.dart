import 'package:flutter/material.dart';

// Mock list of notifications
List<String> mockNotifications = [
  "Camp A needs more supplies.",
  "QRT Beta has completed a rescue operation.",
  "New user registered in the system.",
  "Flood alert issued for Zone 3.",
];

class AdminNotifications extends StatelessWidget {
  const AdminNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mockNotifications.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(mockNotifications[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
