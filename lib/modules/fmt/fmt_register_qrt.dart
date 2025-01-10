import 'package:flutter/material.dart';

class FMTRegisterQRT extends StatefulWidget {
  const FMTRegisterQRT({super.key});

  @override
  _FMTRegisterQRTState createState() => _FMTRegisterQRTState();
}

class _FMTRegisterQRTState extends State<FMTRegisterQRT> {
  final _formKey = GlobalKey<FormState>();
  final _qrtNameController = TextEditingController();
  final _areaController = TextEditingController();
  final _memberCountController = TextEditingController();

  void _registerQRT() {
    if (_formKey.currentState!.validate()) {
      String qrtName = _qrtNameController.text;
      String area = _areaController.text;
      String memberCount = _memberCountController.text;

      // You can add your logic here for QRT registration (e.g., saving to a database)
      print("QRT Registered: Name: $qrtName, Area: $area, Members: $memberCount");

      // Navigate back to the home screen or display a success message
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register QRT"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _qrtNameController,
                decoration: const InputDecoration(labelText: 'QRT Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter QRT name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Assigned Area'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter area';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _memberCountController,
                decoration: const InputDecoration(labelText: 'Team Members'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of members';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerQRT,
                child: const Text("Register QRT"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
