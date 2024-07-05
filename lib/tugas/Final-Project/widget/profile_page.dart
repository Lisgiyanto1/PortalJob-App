import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/userModel.dart';
import 'package:flutter_app/tugas/Final-Project/loginScreen.dart';

import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel loggedInUser = UserModel(
      fullName: '',
      email: '',
      password: '',
      keahlian: '',
      keahlian2: '',
      skillTools: '',
      skillTools2: '',
      skillTools3: '',
      skillToolsImg: '',
      skillToolsImg2: '',
      skillToolsImg3: '',
      socialMedia: '',
      socialMedia2: '',
      socialMedia3: '');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> launchURL(String url, {bool enableJavascript = false}) async {
    try {
      Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error launching URL'),
            content: Text.rich(
              TextSpan(
                text: 'Could not launch ',
                children: [
                  TextSpan(
                    text: 'https://',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '$url: $e, please type https:// on begin'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user-token');
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String uid = auth.currentUser!.uid;
      DocumentReference userRef = firestore.collection('users').doc(uid);
      userRef.get().then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          UserModel user =
              UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
          setState(() {
            loggedInUser = user;
          });
        } else {
          print('User not found in Firestore');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content container
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40)),
                              color: ColorPallete.primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Center(
                                child: Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 460),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Warna border
                              width: 4.0, // Lebar border
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(loggedInUser.photoUrl!),
                            radius: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(bottom: 300, left: 80),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white, // Warna border
                            width: 4.0, // Lebar border
                          ),
                          color: Colors.green[100], // Warna latar belakang
                        ),
                        child: Icon(
                          Icons
                              .edit_document, // Ganti dengan ikon yang diinginkan
                          size:
                              30, // Mengurangi ukuran ikon agar sesuai dengan kontainer
                          color:
                              Colors.blue, // Atur warna ikon sesuai kebutuhan
                        ),
                        // Isi Container di sini
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 200),
                        child: Text(
                          loggedInUser.fullName,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Container(
                        height: 400,
                        width: 370,
                        margin: EdgeInsets.only(top: 270),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), // Warna bayangan
                              spreadRadius: 5, // Jarak penyebaran bayangan
                              blurRadius: 7, // Radius blur bayangan
                              offset:
                                  Offset(0, 3), // Offset bayangan dari objek
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 60, right: 240),
                        child: Text(
                          'Skill Saya',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 240, top: 20),
                        child: Text(
                          'Tools',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 460, left: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(loggedInUser.skillToolsImg),
                          ),
                          SizedBox(
                              width:
                                  10), // Memberikan jarak 10px di antara gambar pertama dan kedua
                          CircleAvatar(
                            radius: 30, // Radius yang sama dengan 85/2
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(loggedInUser.skillToolsImg2),
                          ),
                          SizedBox(
                              width:
                                  10), // Memberikan jarak 10px di antara gambar pertama dan kedua
                          CircleAvatar(
                            radius: 30, // Radius yang sama dengan 85/2
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(loggedInUser.skillToolsImg3),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 230, right: 220),
                        child: Text(
                          'Bidang',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 570, left: 80),
                      child: Text(
                        "• ${loggedInUser.keahlian}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 600, left: 80),
                      child: Text(
                        "• ${loggedInUser.keahlian2}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 450),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5,
                                color: Colors
                                    .black45), // Atur lebar dan warna garis bawah di sini
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final shouldLogout = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning_rounded,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Logout',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  content: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Are you sure you want to logout?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.red[400],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (shouldLogout ?? false) {
                              _signOut().then((value) =>
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red.shade400),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            fixedSize: MaterialStateProperty.all<Size>(
                                Size.fromWidth(280)),
                            elevation: MaterialStateProperty.all<double>(3),
                            shadowColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 550, left: 123),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                launchURL(loggedInUser.socialMedia);
                              },
                              icon: FaIcon(FontAwesomeIcons
                                  .linkedinIn), // Ganti dengan ikon media sosial yang diinginkan
                            ),

                            IconButton(
                              onPressed: () {
                                launchURL(loggedInUser.socialMedia2);
                              },
                              icon: FaIcon(FontAwesomeIcons
                                  .github), // Ganti dengan ikon media sosial yang diinginkan
                            ),

                            ElevatedButton(
                              onPressed: () {
                                launchURL(loggedInUser.socialMedia3);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                elevation: MaterialStateProperty.all<double>(0),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(EdgeInsets.zero),
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Colors
                                    .black, // Sesuaikan warna ikon dengan kebutuhan Anda
                              ),
                            ),
                            // Tambahkan IconButton lainnya sesuai dengan jumlah media sosial yang ingin Anda tampilkan
                          ],
                        ),
                      ),
                    )
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

class LaunchButton extends StatelessWidget {
  final String text;
  final Function onTap;
  LaunchButton(this.onTap, this.text);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
