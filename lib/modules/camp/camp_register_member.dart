import 'package:flutter/material.dart';

class CampRegisterMember extends StatefulWidget {
  const CampRegisterMember({super.key});

  @override
  _CampRegisterMemberState createState() => _CampRegisterMemberState();
}

class _CampRegisterMemberState extends State<CampRegisterMember> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _contactController = TextEditingController();

  void _registerMember() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String age = _ageController.text;
      String contact = _contactController.text;

      // Logic for registering camp members (e.g., saving to a database)
      print("Registered Member: Name: $name, Age: $age, Contact: $contact");

      // Navigate back to the home screen or show a success message
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Camp Member"),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerMember,
                child: const Text("Register Member"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
