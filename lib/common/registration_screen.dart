import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _situationController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List of roles and selected role
  String _selectedRole = '';
  final List<String> _roles = ['Admin', 'FMT', 'QRT', 'User', 'Camp'];

  // Function to handle registration form submission
  Future<void> _handleSubmit() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String situation = _situationController.text;
    String location = _locationController.text;

    // Basic validation
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || _selectedRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (_selectedRole == 'User' && (situation.isEmpty || location.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide situation and location for User role')),
      );
      return;
    }

    try {
      // Create the user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user ID
      String uid = userCredential.user!.uid;

      // Store user information in Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'role': _selectedRole,
        'situation': _selectedRole == 'User' ? situation : null,
        'location': _selectedRole == 'User' ? location : null,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );

      // Optionally navigate to a different screen, e.g., login screen
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Show error message if Firebase Authentication fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/reglogo.png', // Replace with your actual image path
              fit: BoxFit.fill,
            ),
          ),
          // Foreground content with centered alignment
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // White background with some transparency
                  borderRadius: BorderRadius.circular(10), // Rounded corners for the container
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name input
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Email input
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Role selection
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Role'),
                      value: _selectedRole.isEmpty ? null : _selectedRole,
                      items: _roles.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Center(child: Text(role)),
                        );
                      }).toList(),
                      onChanged: (newRole) {
                        setState(() {
                          _selectedRole = newRole!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password input
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Confirm password input
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Additional fields for User role
                    if (_selectedRole == 'User') ...[
                      TextField(
                        controller: _situationController,
                        decoration: const InputDecoration(labelText: 'Situation'),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(labelText: 'Location'),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('View Map clicked')),
                          );
                        },
                        child: const Text('View Map'),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Submit button centered
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
