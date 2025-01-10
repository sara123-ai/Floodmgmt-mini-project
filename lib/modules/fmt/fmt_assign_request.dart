import 'package:flutter/material.dart';

class FMTAssignRequest extends StatefulWidget {
  const FMTAssignRequest({super.key});

  @override
  _FMTAssignRequestState createState() => _FMTAssignRequestState();
}

class _FMTAssignRequestState extends State<FMTAssignRequest> {
  final _formKey = GlobalKey<FormState>();
  final _requestIdController = TextEditingController();
  final _qrtNameController = TextEditingController();

  void _assignRequest() {
    if (_formKey.currentState!.validate()) {
      String requestId = _requestIdController.text;
      String qrtName = _qrtNameController.text;

      // Logic for assigning request to a QRT (e.g., saving to a database)
      print("Request Assigned: Request ID: $requestId, QRT: $qrtName");

      // Navigate back to home screen or show success message
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Request to QRT"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _requestIdController,
                decoration: const InputDecoration(labelText: 'Request ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter request ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qrtNameController,
                decoration: const InputDecoration(labelText: 'Assign to QRT'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter QRT name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _assignRequest,
                child: const Text("Assign Request"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
