import 'package:flutter/material.dart';

// Custom Elevated Button Widget
Widget customButton({
  required String text,
  required VoidCallback onPressed,
  Color color = Colors.blue, // Default button color
  Color textColor = Colors.white, // Default text color
  double width = double.infinity, // Default width to fill the available space
  double padding = 16.0, // Default padding
}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: padding),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: color, // Button text color
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18), // Default font size for button text
      ),
    ),
  );
}

// Custom Text Input Field Widget
Widget customTextField({
  required TextEditingController controller,
  required String labelText,
  bool obscureText = false, // For passwords, default is not obscured
  String? Function(String?)? validator, // Validator function (optional)
  TextInputType keyboardType = TextInputType.text, // Default input type
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
    ),
    validator: validator,
  );
}

// Custom Dropdown Button Widget
Widget customDropdown<T>({
  required String hintText,
  required T? value,
  required List<T> items,
  required ValueChanged<T?> onChanged,
  String? Function(T?)? validator, // Validator function (optional)
}) {
  return DropdownButtonFormField<T>(
    value: value,
    hint: Text(hintText),
    onChanged: onChanged,
    validator: validator,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
    ),
    items: items.map((T item) {
      return DropdownMenuItem<T>(
        value: item,
        child: Text(item.toString()),
      );
    }).toList(),
  );
}

// Custom Profile Tile (for viewing user/camp info)
Widget profileTile({
  required String title,
  required String subtitle,
  IconData? icon, // Optional icon
}) {
  return ListTile(
    leading: icon != null ? Icon(icon, size: 40.0) : null,
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle),
    contentPadding: const EdgeInsets.all(16.0),
    tileColor: Colors.grey[200],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

// Custom Notification Card Widget
Widget notificationCard({
  required String notificationText,
  required String dateTime,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    child: ListTile(
      title: Text(
        notificationText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(dateTime),
      leading: const Icon(Icons.notification_important, color: Colors.red),
    ),
  );
}
