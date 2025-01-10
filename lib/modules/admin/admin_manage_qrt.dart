import 'package:flutter/material.dart';

// A mock list of Quick Response Teams (QRT)
List<Map<String, dynamic>> mockQRT = [
  {'qrtName': 'Team Alpha', 'members': 10, 'area': 'Zone 1'},
  {'qrtName': 'Team Beta', 'members': 8, 'area': 'Zone 2'},
  {'qrtName': 'Team Gamma', 'members': 12, 'area': 'Zone 3'},
];

class AdminManageQRT extends StatefulWidget {
  const AdminManageQRT({super.key});

  @override
  _AdminManageQRTState createState() => _AdminManageQRTState();
}

class _AdminManageQRTState extends State<AdminManageQRT> {
  // Function to handle adding a new QRT
  void _addNewQRT(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddQRTDialog(
          onAddQRT: (qrtName, members, area) {
            setState(() {
              mockQRT.add({
                'qrtName': qrtName,
                'members': members,
                'area': area,
              });
            });
          },
        );
      },
    );
  }

  // Function to handle editing a QRT
  void _editQRT(int index, BuildContext context) {
    final qrt = mockQRT[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddQRTDialog(
          qrtName: qrt['qrtName'],
          members: qrt['members'],
          area: qrt['area'],
          onAddQRT: (newQRTName, newMembers, newArea) {
            setState(() {
              mockQRT[index] = {
                'qrtName': newQRTName,
                'members': newMembers,
                'area': newArea,
              };
            });
          },
        );
      },
    );
  }

  // Function to handle deleting a QRT
  void _deleteQRT(int index) {
    setState(() {
      mockQRT.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage QRT")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mockQRT.length,
                itemBuilder: (context, index) {
                  final qrt = mockQRT[index];
                  return Card(
                    child: ListTile(
                      title: Text(qrt['qrtName']),
                      subtitle: Text('Members: ${qrt['members']}\nArea: ${qrt['area']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editQRT(index, context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteQRT(index),
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
              onPressed: () => _addNewQRT(context),
              child: const Text("Add New QRT"),
            ),
          ],
        ),
      ),
    );
  }
}

// Dialog for adding and editing a QRT
class AddQRTDialog extends StatefulWidget {
  final String? qrtName;
  final int? members;
  final String? area;
  final Function(String, int, String) onAddQRT;

  const AddQRTDialog({super.key, 
    this.qrtName,
    this.members,
    this.area,
    required this.onAddQRT,
  });

  @override
  _AddQRTDialogState createState() => _AddQRTDialogState();
}

class _AddQRTDialogState extends State<AddQRTDialog> {
  late TextEditingController _qrtNameController;
  late TextEditingController _membersController;
  late TextEditingController _areaController;

  @override
  void initState() {
    super.initState();
    _qrtNameController = TextEditingController(text: widget.qrtName);
    _membersController = TextEditingController(text: widget.members?.toString());
    _areaController = TextEditingController(text: widget.area);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.qrtName == null ? "Add New QRT" : "Edit QRT"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _qrtNameController,
            decoration: const InputDecoration(labelText: "QRT Name"),
          ),
          TextField(
            controller: _membersController,
            decoration: const InputDecoration(labelText: "Members"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _areaController,
            decoration: const InputDecoration(labelText: "Area"),
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
            final String qrtName = _qrtNameController.text;
            final int members = int.tryParse(_membersController.text) ?? 0;
            final String area = _areaController.text;

            if (qrtName.isNotEmpty && area.isNotEmpty && members > 0) {
              widget.onAddQRT(qrtName, members, area);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
