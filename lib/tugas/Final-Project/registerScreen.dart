import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Models/toolsList.dart';
import 'package:flutter_app/Models/userModel.dart';
import 'package:flutter_app/tugas/Final-Project/loginScreen.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_app/tugas/Final-Project/services/user-repositorie/users_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  final BuildContext context;
  const RegisterScreen({Key? key, required this.context}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final appUrlController = TextEditingController();
  final appUrlController2 = TextEditingController();
  final appUrlController3 = TextEditingController();
  File? _selectedImage;
  String? selectedAppName;
  String? selectedAppName2;
  String? selectedAppName3;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _keahlianController = TextEditingController();
  TextEditingController _keahlian2Controller = TextEditingController();
  TextEditingController _skillToolsController = TextEditingController();
  TextEditingController _skillTools2Controller = TextEditingController();
  TextEditingController _skillTools3Controller = TextEditingController();
  TextEditingController _skillToolsImgController = TextEditingController();
  TextEditingController _skillToolsImg2Controller = TextEditingController();
  TextEditingController _skillToolsImg3Controller = TextEditingController();
  TextEditingController _socialMediaController = TextEditingController();
  TextEditingController _socialMedia2Controller = TextEditingController();
  TextEditingController _socialMedia3Controller = TextEditingController();
  TextEditingController _controller =
      TextEditingController(text: 'Initial value');

  final FocusNode primaryFocus = FocusNode();

  Future<void> _selectImage(UserModel user) async {
    setState(() {
      _isLoading = true;
    });
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      final imageFile = File(result.files.single.path!);
      final image = result.files.single;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(image.name);
      final uploadTask = storageRef.putFile(imageFile);

      try {
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          _selectedImage = imageFile;
          _controller.text = downloadUrl;
          user.photoUrl = downloadUrl;
          _isLoading = false;
        });
      } on FirebaseException catch (e) {
        // Handle errors during upload
        _showSnackBar(context, 'Failed to upload image: $e');
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<String> _uploadImageToFirebaseStorage(File image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images/${image.path}');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  AppModel? selectedApp, selectedApp2, selectedApp3;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 10),
              const Text(
                'Register to create an account',
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 50),
              _buildRegisterForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Container(
        width: 320,
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                hintText: 'Full Name',
                suffixIcon: Icon(Icons.person),
                filled: true,
                fillColor: ColorPallete.fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                suffixIcon: Icon(Icons.email),
                filled: true,
                fillColor: ColorPallete.fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: Icon(Icons.lock),
                filled: true,
                fillColor: ColorPallete.fieldColor,
                border: OutlineInputBorder(
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
            SizedBox(height: 20),
            Stack(
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Upload Foto Profil',
                    suffixIcon: Stack(
                      children: [
                        if (_isLoading)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: () async {
                            UserModel user = UserModel(
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              photoUrl: _controller.text,
                              password: _passwordController.text,
                              keahlian: _keahlianController.text,
                              keahlian2: _keahlian2Controller.text,
                              skillTools: _skillToolsController.text,
                              skillTools2: _skillTools2Controller.text,
                              skillTools3: _skillTools3Controller.text,
                              skillToolsImg: _skillToolsImgController.text,
                              skillToolsImg2: _skillToolsImg2Controller.text,
                              skillToolsImg3: _skillToolsImg3Controller.text,
                              socialMedia: _socialMediaController.text,
                              socialMedia2: _socialMedia2Controller.text,
                              socialMedia3: _socialMedia3Controller.text,
                              // Set the user's ID to the unique ID generated by Firebase Authentication
                              id: '',
                            );
                            await _selectImage(user);
                          },
                        ),
                      ],
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (_selectedImage == null) {
                      return 'Please select an image';
                    }
                    return null;
                  },
                ),
                if (_selectedImage != null)
                  Positioned(
                    right: 50,
                    top: 14,
                    child: CircleAvatar(
                      backgroundImage: FileImage(_selectedImage!),
                      radius: 17,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _keahlianController,
              decoration: InputDecoration(
                labelText: 'Skills',
                hintText: 'Enter your skills separated by commas',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your skills';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _keahlian2Controller,
              decoration: InputDecoration(
                labelText: 'Skills2',
                hintText: 'Enter your others skills separated by commas',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your skills 2';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex:
                      3, // Mengatur flex menjadi 3 agar DropdownButtonFormField memiliki panjang 30%
                  child: DropdownButtonFormField<AppModel>(
                    value: selectedApp,
                    onChanged: (AppModel? newValue) {
                      setState(() {
                        selectedApp = newValue;
                        if (newValue != null) {
                          selectedAppName = newValue
                              .name; // Menyimpan nama aplikasi yang dipilih
                          _skillToolsController.text = newValue.name;
                          _skillToolsImgController.text = newValue.url;
                          appUrlController.text = newValue.url;
                        } else {
                          selectedAppName =
                              null; // Mengosongkan nama aplikasi yang dipilih
                          _skillToolsController.text = '';
                          _skillToolsImgController.text = '';
                          appUrlController.text = '';
                        }
                      });
                    },
                    elevation: 3,
                    isExpanded: true,
                    isDense: true,
                    focusNode: primaryFocus,
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: Colors.white,
                    icon: FaIcon(FontAwesomeIcons.appStore),
                    iconSize: 25,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16),
                    hint: Text('Pilih'), // Menampilkan hint di label dropdown
                    items: appOptions.map((AppModel app) {
                      return DropdownMenuItem<AppModel>(
                        value: app,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ColorPallete.primaryColor,
                                      width: 1))),
                          child: Text(app.name),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: selectedAppName ??
                          'Skill Tools', // Menggunakan hasil pilihan atau hint jika tidak ada yang dipilih
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Pilih salah satu aplikasi';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex:
                      7, // Mengatur flex menjadi 7 agar TextFormField memiliki panjang 70%
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'URL Aplikasi',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: appUrlController,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex:
                      3, // Mengatur flex menjadi 3 agar DropdownButtonFormField memiliki panjang 30%
                  child: DropdownButtonFormField<AppModel>(
                    value: selectedApp2,
                    onChanged: (AppModel? newValue) {
                      setState(() {
                        selectedApp2 = newValue;
                        if (newValue != null) {
                          selectedAppName2 = newValue
                              .name; // Menyimpan nama aplikasi yang dipilih
                          _skillTools2Controller.text = newValue.name;
                          _skillToolsImg2Controller.text = newValue.url;
                          appUrlController2.text = newValue.url;
                        } else {
                          selectedAppName2 =
                              null; // Mengosongkan nama aplikasi yang dipilih
                          _skillTools2Controller.text = '';
                          _skillToolsImg2Controller.text = '';
                          appUrlController2.text = '';
                        }
                      });
                    },
                    elevation: 3,
                    isExpanded: true,
                    isDense: true,
                    focusNode: primaryFocus,
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: Colors.white,
                    icon: FaIcon(FontAwesomeIcons.appStore),
                    iconSize: 25,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16),
                    hint: Text('Pilih'), // Menampilkan hint di label dropdown
                    items: appOptions.map((AppModel app) {
                      return DropdownMenuItem<AppModel>(
                        value: app,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ColorPallete.primaryColor,
                                      width: 1))),
                          child: Text(app.name),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: selectedAppName2 ??
                          'Skill Tools 2', // Menggunakan hasil pilihan atau hint jika tidak ada yang dipilih
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Pilih salah satu aplikasi';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex:
                      7, // Mengatur flex menjadi 7 agar TextFormField memiliki panjang 70%
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'URL Aplikasi',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: appUrlController2,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex:
                      3, // Mengatur flex menjadi 3 agar DropdownButtonFormField memiliki panjang 30%
                  child: DropdownButtonFormField<AppModel>(
                    value: selectedApp3,
                    onChanged: (AppModel? newValue) {
                      setState(() {
                        selectedApp3 = newValue;
                        if (newValue != null) {
                          selectedAppName3 = newValue
                              .name; // Menyimpan nama aplikasi yang dipilih
                          _skillTools3Controller.text = newValue.name;
                          _skillToolsImg3Controller.text = newValue.url;
                          appUrlController3.text = newValue.url;
                        } else {
                          selectedAppName3 =
                              null; // Mengosongkan nama aplikasi yang dipilih
                          _skillTools3Controller.text = '';
                          _skillToolsImg3Controller.text = '';
                          appUrlController3.text = '';
                        }
                      });
                    },
                    elevation: 3,
                    isExpanded: true,
                    isDense: true,
                    focusNode: primaryFocus,
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: Colors.white,
                    icon: FaIcon(FontAwesomeIcons.appStore),
                    iconSize: 25,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16),
                    hint: Text('Pilih'), // Menampilkan hint di label dropdown
                    items: appOptions.map((AppModel app) {
                      return DropdownMenuItem<AppModel>(
                        value: app,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ColorPallete.primaryColor,
                                      width: 1))),
                          child: Text(app.name),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: selectedAppName3 ??
                          'Skill Tools 3', // Menggunakan hasil pilihan atau hint jika tidak ada yang dipilih
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Pilih salah satu aplikasi';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex:
                      7, // Mengatur flex menjadi 7 agar TextFormField memiliki panjang 70%
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'URL Aplikasi',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: appUrlController3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _socialMediaController,
              decoration: InputDecoration(
                labelText: 'LinkedIn Link',
                hintText: 'Enter your LinkedIn URL ',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your LinkedIn link';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _socialMedia2Controller,
              decoration: InputDecoration(
                labelText: 'Github Link',
                hintText: 'Enter your Github URL ',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your github link';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _socialMedia3Controller,
              decoration: InputDecoration(
                labelText: 'Instagram Link',
                hintText: 'Enter your Instagram URL ',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your instagram link';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        ),
                      },
                      child: Text(
                        'LOG',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w700 // Adjust font size as needed
                            ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white, // Text color
                        backgroundColor: ColorPallete
                            .primaryColor, // Button background color
                        minimumSize: Size(300, 60), // Button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Spasi antara tombol
                Flexible(
                  flex: 8,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          UserModel user = UserModel(
                            fullName: _fullNameController.text,
                            email: _emailController.text,
                            photoUrl: _controller.text,
                            password: _passwordController.text,
                            keahlian: _keahlianController.text,
                            keahlian2: _keahlian2Controller.text,
                            skillTools: _skillToolsController.text,
                            skillTools2: _skillTools2Controller.text,
                            skillTools3: _skillTools3Controller.text,
                            skillToolsImg: _skillToolsImgController.text,
                            skillToolsImg2: _skillToolsImg2Controller.text,
                            skillToolsImg3: _skillToolsImg3Controller.text,
                            socialMedia: _socialMediaController.text,
                            socialMedia2: _socialMedia2Controller.text,
                            socialMedia3: _socialMedia3Controller.text,
                            // Set the user's ID to the unique ID generated by Firebase Authentication
                            id: userCredential.user!.uid,
                          );

                          if (_selectedImage != null) {
                            await UserRepository()
                                .registerUser(user, _selectedImage!);
                          } else {
                            await UserRepository().registerUser(user, File(''));
                          }

                          // Registration successful, navigate to the next screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pendaftaran berhasil'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        } on FirebaseAuthException catch (e) {
                          // Handle FirebaseAuthException
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message!),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } catch (error) {
                          // Handle other errors
                          print('Failed to register user: $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Gagal melakukan pendaftaran'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Register',
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
