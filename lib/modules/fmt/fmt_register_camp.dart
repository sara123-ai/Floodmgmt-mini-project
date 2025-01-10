import 'package:flutter/material.dart';

class FMTRegisterCamp extends StatefulWidget {
  const FMTRegisterCamp({super.key});

  @override
  _FMTRegisterCampState createState() => _FMTRegisterCampState();
}

class _FMTRegisterCampState extends State<FMTRegisterCamp> {
  final _formKey = GlobalKey<FormState>();
  final _campNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _capacityController = TextEditingController();

  void _registerCamp() {
    if (_formKey.currentState!.validate()) {
      String campName = _campNameController.text;
      String location = _locationController.text;
      String capacity = _capacityController.text;

      // You can add your logic here for camp registration (e.g., saving to a database)
      print("Camp Registered: Name: $campName, Location: $location, Capacity: $capacity");

      // Navigate back to the home screen or display a success message
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Camp"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _campNameController,
                decoration: const InputDecoration(labelText: 'Camp Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter camp name';
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
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(labelText: 'Capacity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter capacity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerCamp,
                child: const Text("Register Camp"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
