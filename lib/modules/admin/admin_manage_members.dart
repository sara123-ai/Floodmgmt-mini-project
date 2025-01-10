import 'package:flutter/material.dart';

// A mock list of members
List<Map<String, dynamic>> mockMembers = [
  {'name': 'John Doe', 'role': 'Admin', 'contact': '1234567890'},
  {'name': 'Jane Smith', 'role': 'Camp Manager', 'contact': '0987654321'},
  {'name': 'Mike Johnson', 'role': 'QRT Member', 'contact': '1122334455'},
];

class AdminManageMembers extends StatefulWidget {
  const AdminManageMembers({super.key});

  @override
  _AdminManageMembersState createState() => _AdminManageMembersState();
}

class _AdminManageMembersState extends State<AdminManageMembers> {
  // Function to add a new member
  void _addNewMember(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddMemberDialog(
          onAddMember: (name, role, contact) {
            setState(() {
              mockMembers.add({
                'name': name,
                'role': role,
                'contact': contact,
              });
            });
          },
        );
      },
    );
  }

  // Function to edit a member
  void _editMember(int index, BuildContext context) {
    final member = mockMembers[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddMemberDialog(
          name: member['name'],
          role: member['role'],
          contact: member['contact'],
          onAddMember: (newName, newRole, newContact) {
            setState(() {
              mockMembers[index] = {
                'name': newName,
                'role': newRole,
                'contact': newContact,
              };
            });
          },
        );
      },
    );
  }

  // Function to delete a member
  void _deleteMember(int index) {
    setState(() {
      mockMembers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Members")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mockMembers.length,
                itemBuilder: (context, index) {
                  final member = mockMembers[index];
                  return Card(
                    child: ListTile(
                      title: Text(member['name']),
                      subtitle: Text('Role: ${member['role']}\nContact: ${member['contact']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editMember(index, context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteMember(index),
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
              onPressed: () => _addNewMember(context),
              child: const Text("Add New Member"),
            ),
          ],
        ),
      ),
    );
  }
}

// Dialog for adding and editing members
class AddMemberDialog extends StatefulWidget {
  final String? name;
  final String? role;
  final String? contact;
  final Function(String, String, String) onAddMember;

  const AddMemberDialog({super.key, 
    this.name,
    this.role,
    this.contact,
    required this.onAddMember,
  });

  @override
  _AddMemberDialogState createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _roleController = TextEditingController(text: widget.role);
    _contactController = TextEditingController(text: widget.contact);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.name == null ? "Add New Member" : "Edit Member"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: _roleController,
            decoration: const InputDecoration(labelText: "Role"),
          ),
          TextField(
            controller: _contactController,
            decoration: const InputDecoration(labelText: "Contact"),
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
            final String name = _nameController.text;
            final String role = _roleController.text;
            final String contact = _contactController.text;

            if (name.isNotEmpty && role.isNotEmpty && contact.isNotEmpty) {
              widget.onAddMember(name, role, contact);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
