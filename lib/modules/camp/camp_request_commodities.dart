import 'package:flutter/material.dart';

class CampRequestCommodities extends StatefulWidget {
  const CampRequestCommodities({super.key});

  @override
  _CampRequestCommoditiesState createState() => _CampRequestCommoditiesState();
}

class _CampRequestCommoditiesState extends State<CampRequestCommodities> {
  final _formKey = GlobalKey<FormState>();
  final _commodityController = TextEditingController();
  final _quantityController = TextEditingController();

  void _requestCommodities() {
    if (_formKey.currentState!.validate()) {
      String commodity = _commodityController.text;
      String quantity = _quantityController.text;

      // Logic to request commodities (e.g., save to a database)
      print("Requested Commodities: $commodity, Quantity: $quantity");

      // Navigate back to the home screen or show a success message
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Commodities"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _commodityController,
                decoration: const InputDecoration(labelText: 'Commodity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the commodity name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _requestCommodities,
                child: const Text("Request Commodities"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
