import 'package:flutter/material.dart';

class QRTRegisterRescue extends StatefulWidget {
  const QRTRegisterRescue({super.key});

  @override
  _QRTRegisterRescueState createState() => _QRTRegisterRescueState();
}

class _QRTRegisterRescueState extends State<QRTRegisterRescue> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();

  void _registerRescue() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String age = _ageController.text;
      String contact = _contactController.text;
      String location = _locationController.text;

      // Logic for registering rescued person (e.g., saving to a database)
      print("Rescue Registered: Name: $name, Age: $age, Contact: $contact, Location: $location");

      // Navigate back to the home screen or show success message
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Rescued Person"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerRescue,
                child: const Text("Register Rescue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
