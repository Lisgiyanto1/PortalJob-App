import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Job_model.dart';
import "package:carousel_slider/carousel_slider.dart";
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';

class Freelance extends StatefulWidget {
  final List<Job> jobs;

  Freelance({required this.jobs});

  @override
  _FreelanceState createState() => _FreelanceState();
}

class _FreelanceState extends State<Freelance> {
  int _currentIndex = 0;
  late Timer _timer;
  bool _isShowingFreelance = true; // Tambah variabel ini

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        _isShowingFreelance = !_isShowingFreelance; // Beralih jenis pekerjaan
        if (_isShowingFreelance) {
          // Jika menampilkan pekerjaan freelance, atur currentIndex kembali ke 0
          _currentIndex = 0;
        } else {
          // Jika menampilkan pekerjaan full-time, atur currentIndex sesuai jika perlu
          _currentIndex = (_currentIndex + 1) % widget.jobs.length;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs = _isShowingFreelance
        ? widget.jobs.where((job) => job.jobType == 'Freelance').toList()
        : widget.jobs.where((job) => job.jobType == 'Fulltime').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            _isShowingFreelance ? 'Pekerjaan Freelance' : 'Pekerjaan Full-time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ColorPallete.titleContent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: filteredJobs.isNotEmpty
              ? CarouselSlider(
                  options: CarouselOptions(
                    height: 80.0,
                    viewportFraction: 0.9,
                    enableInfiniteScroll: filteredJobs.length > 1,
                    autoPlay: filteredJobs.length > 1,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    // Menambahkan jarak antara item
                  ),
                  items: filteredJobs.map((job) {
                    return Container(
                      margin: EdgeInsets.all(2),
                      width: 345,
                      height: 58,
                      decoration: BoxDecoration(
                        color: ColorPallete.slider,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(job.imageUrl!),
                              radius: 30.0,
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  job.jobCategory!,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  job.jobType!,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              : Text('Tidak ada pekerjaan tersedia'),
        ),
      ],
    );
  }
}
