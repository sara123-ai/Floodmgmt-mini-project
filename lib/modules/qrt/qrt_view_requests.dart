import 'package:flutter/material.dart';

class QRTViewRequests extends StatelessWidget {
  // Mock list of rescue requests
  final List<String> requests = [
    "User A - Request for rescue in Zone 1",
    "User B - Request for rescue in Zone 2",
    "User C - Request for rescue in Zone 3",
    "User D - Request for rescue in Zone 4",
  ];

   QRTViewRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Rescue Requests"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(requests[index]),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Navigate to the rescue registration page
                    Navigator.pushNamed(context, '/qrt_register_rescue');
                  },
                  child: const Text("Rescue"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
