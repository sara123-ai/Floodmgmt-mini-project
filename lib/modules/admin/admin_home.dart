// modules/admin/admin_home.dart
import 'package:flutter/material.dart';
import 'admin_manage_camp.dart';
import 'admin_manage_qrt.dart';
import 'admin_manage_members.dart';
import 'admin_notifications.dart';
import 'admin_view_details.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image that fills the entire screen
        Positioned.fill(
          child: Image.asset(
            'assets/images/adminbg.png', // Path to your background image
            fit: BoxFit.fill,
          ),
        ),

        // Scaffold with transparent app bar
        Scaffold(
          backgroundColor: Colors.transparent, // Make Scaffold background transparent
          appBar: AppBar(
            title: const Text("Admin Home"),
            backgroundColor: const Color.fromARGB(255, 230, 235, 240).withOpacity(0.10), // Semi-transparent app bar
            elevation: 0, // Remove shadow for a cleaner look
          ),
          body: Center(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                ListTile(
                  tileColor: Colors.white.withOpacity(0.10), // Background color for clarity
                  title: const Center(child: Text('Manage Camps')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminManageCamp()),
                    );
                  },
                ),
                const SizedBox(height: 7),
                ListTile(
                  tileColor: Colors.white.withOpacity(0.10),
                  title: const Center(child: Text('Manage Quick Response Team')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminManageQRT()),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  tileColor: Colors.white.withOpacity(0.10),
                  title: const Center(child: Text('Manage Members')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminManageMembers()),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  tileColor: Colors.white.withOpacity(0.10),
                  title: const Center(child: Text('Display Notifications')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminNotifications()),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  tileColor: Colors.white.withOpacity(0.10),
                  title: const Center(child: Text('View Details')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminViewDetails()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
