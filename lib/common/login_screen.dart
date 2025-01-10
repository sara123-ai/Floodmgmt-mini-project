import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Selected role
  String _selectedRole = '';
  final List<String> _roles = ['Admin', 'FMT', 'QRT', 'User', 'Camp'];

  // Handle login with Firebase Authentication
  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      if (_selectedRole.isNotEmpty) {
        try {
          // Authenticate user with Firebase
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Get user role from Firestore
          String uid = userCredential.user!.uid;
          DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

          if (userDoc.exists) {
            String storedRole = userDoc['role'];
            // Ensure the selected role matches the stored role
            if (_selectedRole == storedRole) {
              // Navigate based on the selected role
              switch (_selectedRole) {
                case 'Admin':
                  Navigator.pushNamed(context, '/admin');
                  break;
                case 'FMT':
                  Navigator.pushNamed(context, '/fmt');
                  break;
                case 'QRT':
                  Navigator.pushNamed(context, '/qrt');
                  break;
                case 'User':
                  Navigator.pushNamed(context, '/user');
                  break;
                case 'Camp':
                  Navigator.pushNamed(context, '/camp');
                  break;
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid role selected')),
                  );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Role does not match')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not found')),
            );
          }
        } on FirebaseAuthException catch (e) {
          String message;
          switch (e.code) {
            case 'user-not-found':
              message = 'No user found for that email.';
              break;
            case 'wrong-password':
              message = 'Wrong password provided for that user.';
              break;
            case 'invalid-email':
              message = 'The email address is not valid.';
              break;
            default:
              message = 'An undefined error happened.';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a role')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/login.png', // Replace with your image path
            fit: BoxFit.fill,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 150,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _roles.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRole = _roles[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedRole == _roles[index]
                                    ? Colors.blueAccent
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  _roles[index],
                                  style: TextStyle(
                                    color: _selectedRole == _roles[index]
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      child: const Text(
                        "Create a new account",
                        style: TextStyle(color: Color.fromARGB(255, 75, 43, 82)),
                      ),
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
