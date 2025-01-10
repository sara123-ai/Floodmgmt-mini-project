import 'package:flutter/material.dart';

// A mock list of camps to display
List<Map<String, dynamic>> mockCamps = [
  {'campName': 'Camp A', 'location': 'Location 1', 'capacity': 100},
  {'campName': 'Camp B', 'location': 'Location 2', 'capacity': 150},
  {'campName': 'Camp C', 'location': 'Location 3', 'capacity': 200},
];

class AdminManageCamp extends StatefulWidget {
  const AdminManageCamp({super.key});

  @override
  _AdminManageCampState createState() => _AdminManageCampState();
}

class _AdminManageCampState extends State<AdminManageCamp> {
  // Function to handle adding a new camp
  void _addNewCamp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCampDialog(
          onAddCamp: (campName, location, capacity) {
            setState(() {
              mockCamps.add({
                'campName': campName,
                'location': location,
                'capacity': capacity,
              });
            });
          },
        );
      },
    );
  }

  // Function to handle editing a camp
  void _editCamp(int index, BuildContext context) {
    final camp = mockCamps[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCampDialog(
          campName: camp['campName'],
          location: camp['location'],
          capacity: camp['capacity'],
          onAddCamp: (newCampName, newLocation, newCapacity) {
            setState(() {
              mockCamps[index] = {
                'campName': newCampName,
                'location': newLocation,
                'capacity': newCapacity,
              };
            });
          },
        );
      },
    );
  }

  // Function to handle deleting a camp
  void _deleteCamp(int index) {
    setState(() {
      mockCamps.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Camps"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mockCamps.length,
                itemBuilder: (context, index) {
                  final camp = mockCamps[index];
                  return Card(
                    child: ListTile(
                      title: Text(camp['campName']),
                      subtitle: Text('Location: ${camp['location']}\nCapacity: ${camp['capacity']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editCamp(index, context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteCamp(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addNewCamp(context),
              child: const Text("Add New Camp"),
            ),
          ],
        ),
      ),
    );
  }
}

// Dialog for adding and editing a camp
class AddCampDialog extends StatefulWidget {
  final String? campName;
  final String? location;
  final int? capacity;
  final Function(String, String, int) onAddCamp;

  const AddCampDialog({super.key, 
    this.campName,
    this.location,
    this.capacity,
    required this.onAddCamp,
  });

  @override
  _AddCampDialogState createState() => _AddCampDialogState();
}

class _AddCampDialogState extends State<AddCampDialog> {
  late TextEditingController _campNameController;
  late TextEditingController _locationController;
  late TextEditingController _capacityController;

  @override
  void initState() {
    super.initState();
    _campNameController = TextEditingController(text: widget.campName);
    _locationController = TextEditingController(text: widget.location);
    _capacityController = TextEditingController(text: widget.capacity?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.campName == null ? "Add New Camp" : "Edit Camp"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _campNameController,
            decoration: const InputDecoration(labelText: "Camp Name"),
          ),
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(labelText: "Location"),
          ),
          TextField(
            controller: _capacityController,
            decoration: const InputDecoration(labelText: "Capacity"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final String campName = _campNameController.text;
            final String location = _locationController.text;
            final int capacity = int.tryParse(_capacityController.text) ?? 0;

            if (campName.isNotEmpty && location.isNotEmpty && capacity > 0) {
              widget.onAddCamp(campName, location, capacity);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
