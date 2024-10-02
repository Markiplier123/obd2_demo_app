import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart'; // Navigate here or a different page post-signup as needed

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _jobsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/login.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color.fromARGB(173, 13, 13, 13)),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(173, 13, 13, 13),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Ensures the title is centered
                  ],
                ),
              ),
              const SizedBox(height: 38),
              const Center(
                child: Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 127, 29, 29),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: const Icon(Icons.person),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          // TextFormField(
                          //   controller: _ageController,
                          //   decoration: InputDecoration(
                          //     labelText: 'Age',
                          //     prefixIcon: const Icon(Icons.cake),
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(8.0),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Enter your age';
                          //     }
                          //     return null;
                          //   },
                          //   keyboardType: TextInputType.number,
                          // ),
                          // const SizedBox(height: 10),
                          // TextFormField(
                          //   controller: _jobsController,
                          //   decoration: InputDecoration(
                          //     labelText: 'Job',
                          //     prefixIcon: const Icon(Icons.work),
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(8.0),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Enter your job';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // const SizedBox(height: 10),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) => _validateEmail(value),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) => _validatePassword(value),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _isRegistering ? null : _register,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity,
                                  50), // double.infinity is the width
                            ),
                            child: _isRegistering
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null ||
        !RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isRegistering = true);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (userCredential.user != null) {
          // Send verification email
          await userCredential.user!.sendEmailVerification();
          // Save user data to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'name': _nameController.text,
            // 'age': _ageController.text,
            // 'job': _jobsController.text,
            'email': _emailController.text,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Verification email has been sent. Please check your email.'),
              duration: Duration(seconds: 5),
            ),
          );

          // Optionally redirect the user to a page where they can await verification
          // For now, we redirect back to login page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginPage()), // Adjust according to your app's flow
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      } finally {
        setState(() => _isRegistering = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    // _ageController.dispose();
    // _jobsController.dispose();
    super.dispose();
  }
}
