import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Models/Job_model.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:flutter_app/tugas/Final-Project/splash_screen.dart';
import 'package:flutter_app/tugas/Final-Project/widget/Recently.dart';

import '../../Models/userModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = ['Development', 'Design', 'Product'];

  User? user;
  String? jobCategory;
  List<Job> filteredJobs = [];
  List<Job> searchJobs = [];
  ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  bool isHomeSelected = true;
  final Debouncer debouncer = Debouncer(duration: Duration(seconds: 1));
  final searchFieldController = TextEditingController();
  double originalPreferredSizeHeight = 125.0;
  bool isLoading = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    user = FirebaseAuth.instance.currentUser;
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
    getData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    searchFieldController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _showAppBar = true;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _showAppBar = false;
      });
    }
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    debouncer.run(() async {
      var data = await Future.wait([
        Future.delayed(Duration(seconds: 0), () {
          return jobs;
        })
      ]);

      if (searchFieldController.text.isEmpty) {
        try {
          setState(() {
            searchJobs = [];
            isLoading = false; // Pindahkan setState ke sini
          });
        } catch (e) {
          // Tambahkan penanganan kesalahan di sini jika diperlukan
          print("Error: $e");
        }
      } else {
        String keyword = searchFieldController.text.toLowerCase();
        setState(() {
          searchJobs = data[0].where((job) {
            return job.name_perusahaan!.toLowerCase().contains(keyword) ||
                job.jobCategory!.toLowerCase().contains(keyword);
          }).toList();
          isLoading = false; // Pindahkan setState ke sini
        });
      }
    });
  }

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
      socialMedia3: '',
      photoUrl: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Tampilkan splash screen di sini

          setState(() {
            SplashScreen();
            isLoading = true;
          });

          // Tunggu sebentar untuk memberikan kesan bahwa sedang loading
          await Future.delayed(Duration(milliseconds: 500));

          // Panggil getData untuk memperbarui data
          await getData();

          // Sembunyikan splash screen setelah selesai memperbarui data
          setState(() {
            isLoading = false;
          });
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 100.0,
              pinned: true,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ColoredBox(color: Colors.white),
              ),
              collapsedHeight: _showAppBar ? 200 : 0,
              toolbarHeight: _showAppBar ? 200 : 0,
              actions: [
                AnimatedOpacity(
                  opacity: _showAppBar ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 70, top: 70),
                    child: Row(
                      children: [
                        Text(
                          "Temukan Pekerjaan\nyang Cocok untuk Anda!",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 25),
                  child: AnimatedOpacity(
                    opacity: _showAppBar ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(loggedInUser.photoUrl!),
                          radius: 20.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(125),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 241,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorPallete.primaryColor,
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchFieldController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search,
                                            color: Colors.grey),
                                        hintText: 'Cari...',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        getData();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorPallete.primaryColor,
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.filter_list,
                                    size: 24,
                                    color: ColorPallete.primaryColor,
                                  ),
                                  onSelected: (value) {
                                    setState(() {
                                      if (value == 'All') {
                                        jobCategory = null;
                                      } else {
                                        jobCategory = value;
                                      }
                                      filteredJobs = jobs.where((job) {
                                        if (jobCategory == null) {
                                          return true;
                                        }
                                        return job.jobCategory == jobCategory;
                                      }).toList();
                                    });
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'All',
                                      child: Text('Semua'),
                                    ),
                                    PopupMenuItem(
                                      value: 'UI Designer',
                                      child: Text('UI Designer'),
                                    ),
                                    PopupMenuItem(
                                      value: 'UX Designer',
                                      child: Text('UX Designer'),
                                    ),
                                    PopupMenuItem(
                                      value: 'Product Designer',
                                      child: Text('Product Designer'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: List.generate(
                            categories.length,
                            (index) => ChoiceChip(
                              label: Text(categories[index]),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              selected: false,
                              onSelected: (bool selected) {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                if (isLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                if (searchJobs.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 24,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Hasil Pencarian',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchJobs.length > 5 ? 5 : searchJobs.length,
                    itemBuilder: (context, index) {
                      final job = searchJobs[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(job.imageUrl!),
                          radius: 25,
                        ),
                        title: Text(job.name_perusahaan!),
                        subtitle: Text(job.jobCategory!),
                        trailing: Text(job.jobType!),
                      );
                    },
                  ),
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      JobList(
                        jobs: jobs,
                        jobCategory: jobCategory,
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({required this.duration});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
}
