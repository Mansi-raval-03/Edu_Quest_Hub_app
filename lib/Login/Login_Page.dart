import 'package:flutter/material.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
      _formKey.currentState?.reset();
    });
  }

  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);
      // Simulate authentication delay
      Future.delayed(Duration(seconds: 2), () {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isLogin ? 'Logged in!' : 'Account created!')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Sign Up'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) => email = val,
                      validator: (val) {
                        if (val == null || !val.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onChanged: (val) => password = val,
                      validator: (val) {
                      if (val == null || val.length < 6) return 'Password must be at least 6 characters';
                      return null;
                      },
                    ),
                    if (!isLogin) ...[
                      SizedBox(height: 16),
                      TextFormField(
                      key: ValueKey('confirmPassword'),
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      onChanged: (val) => confirmPassword = val,
                      validator: (val) {
                        if (val != password) return 'Passwords do not match';
                        return null;
                      },
                      ),
                    ],
                    SizedBox(height: 24),
                    isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: submit,
                        child: Text(isLogin ? 'Login' : 'Sign Up'),
                        ),
                    TextButton(
                      onPressed: toggleForm,
                      child: Text(isLogin
                        ? "Don't have an account? Sign Up"
                        : "Already have an account? Login"),
                    ),
  
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}