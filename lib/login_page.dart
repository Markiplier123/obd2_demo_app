import 'package:app_chan_doan/menu_page.dart';
import 'package:app_chan_doan/sigup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/login.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Center(
                      child: Image.asset(
                        'assets/images/logoBK.png',
                        width: 150,
                        height: 130,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Welcome!',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email', prefixIcon: Icon(Icons.email)),
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_errorMessage != null)
                          Expanded(
                            child: Text(_errorMessage!,
                                style: const TextStyle(
                                    color: Colors.redAccent, fontSize: 14),
                                textAlign: TextAlign.left),
                          ),
                        TextButton(
                          onPressed: _sendPasswordResetEmail,
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _attemptLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Sign In',
                          style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage())),
                      child: const Text('No account? Sign up here',
                          style: TextStyle(
                              fontFamily: 'Times',
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
              ),
            ),
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

  void _attemptLogin() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  void _login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MenuPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please verify your email address to proceed.'),
              duration: Duration(seconds: 5),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Incorrect password or email';
      });
    }
  }

  void _sendPasswordResetEmail() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _errorMessage =
            "Please enter your email address to reset your password.";
      });
      return;
    }
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      setState(() {
        _errorMessage =
            "Password reset email sent. Check your email to reset your password.";
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error sending password reset email: ${e.toString()}";
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
