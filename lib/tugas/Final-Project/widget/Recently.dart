import 'package:flutter/material.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:flutter_app/tugas/Final-Project/widget/Freelance.dart';
import 'package:flutter_app/tugas/Final-Project/widget/Recomendation.dart';
import '../../../Models/Job_model.dart';

class JobList extends StatefulWidget {
  final List<Job> jobs;
  String? jobCategory;

  JobList({Key? key, required this.jobs, this.jobCategory}) : super(key: key);

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  bool seeAllPressed = false;

  @override
  Widget build(BuildContext context) {
    List<Job> filteredJobs =
        widget.jobCategory == null || widget.jobCategory == 'All'
            ? widget.jobs
            : widget.jobs
                .where((job) => job.jobCategory == widget.jobCategory)
                .toList();

    return Column(
      children: [
        if (filteredJobs.length > 2)
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: Text(
                      'Baru Diposting',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        seeAllPressed = !seeAllPressed;
                      });
                    },
                    child: Text(
                      seeAllPressed ? 'Hide' : 'See All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                itemCount: seeAllPressed ? filteredJobs.length : 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    mainAxisExtent: 200),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Job job = filteredJobs[index];
                  return buildJobCard(job);
                },
              ),
            ],
          )
        else
          GridView.builder(
            itemCount: filteredJobs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              mainAxisSpacing: 12.0,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Job job = filteredJobs[index];
              return buildJobCard(job);
            },
          ),
        SizedBox(height: 10),
        Freelance(jobs: widget.jobs),
        HighSalaryRecommendation(jobs: jobs),
      ],
    );
  }

  Widget buildJobCard(Job job) {
    return Card(
      color: widget.jobs.indexOf(job) % 2 == 0
          ? Colors.red.shade300
          : ColorPallete.primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                child: Container(
                  padding: EdgeInsets.all(2),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: ColorPallete.primaryColor,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Image.network(job.imageUrl!),
                ),
              ),
            ),
            ListTile(
              title: Text(
                job.name_perusahaan!,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${job.job_experience} tahun pengalaman',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: Text(
                      job.jobType!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
