import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/tugas/Final-Project/navigation.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:flutter_app/tugas/Final-Project/registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color borderColor = Colors.cyan.shade100;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  bool _isObscureText = true;
  Color _borderColor = Colors.grey;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void showSnackBarWithExclamation(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.warning_rounded, // replace with your desired icon
            color: Colors.yellow,
          ),
          const SizedBox(width: 8),
          const Text(
            'Terjadi kesalahan, silahkan coba lagi.',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> forgotPassword() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      showSnackBarWithExclamation(context);
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      final snackBar = SnackBar(
          content: Text('Silahkan cek email Anda untuk mereset password'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Sign in to continue ',
                style: TextStyle(
                    fontFamily: 'Monserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Container(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      suffixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: ColorPallete.fieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: _borderColor),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey1,
                child: Container(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscureText,
                    decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: ColorPallete.fieldColor,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(_isObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscureText = !_isObscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: _borderColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 75.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        // Menggunakan userCredential
                        print(
                            'User berhasil login dengan ID: ${userCredential.user!.uid}');

                        // Mengambil token dari userCredential
                        String? token = await userCredential.user!.getIdToken();

                        // Menyimpan token
                        await saveToken(token!);

                        // Jika login berhasil, redirect ke halaman utama atau halaman lain yang diinginkan
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationBarScreen(
                                  user: userCredential.user)),
                          (Route<dynamic> route) => false,
                        );

                        setState(() {
                          _isLoading = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        final snackBar = SnackBar(content: Text(e.message!));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorPallete.primaryColor,
                      minimumSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: forgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: ColorPallete.linkText),
                    ),
                  ),
                  Text(
                    'or',
                    style: TextStyle(color: ColorPallete.linkText),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen(
                                  context: context,
                                )),
                      );
                    },
                    child: Text(
                      'Register Now',
                      style: TextStyle(color: ColorPallete.linkText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan token
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user-token", token);
  }
}
