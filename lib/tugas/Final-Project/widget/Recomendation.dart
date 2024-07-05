import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Job_model.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';

class HighSalaryRecommendation extends StatelessWidget {
  final List<Job> jobs;

  const HighSalaryRecommendation({required this.jobs});

  String formatSalaryWithJT(String salary) {
    int length = salary.length;
    if (length >= 6) {
      int jtCount = length ~/ 5;
      return 'Rp ${salary.substring(0, length - (jtCount * 5))} JT';
    } else {
      return 'Rp $salary';
    }
  }

  @override
  Widget build(BuildContext context) {
    jobs.sort((a, b) => b.job_salary!.compareTo(a.job_salary!));

    double highestSalary = jobs.isNotEmpty ? jobs[0].job_salary! : 0;

    final highestPaidJobs =
        jobs.where((job) => job.job_salary == highestSalary).toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 30),
              child: Text(
                'Rekomendasi Gaji Tinggi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorPallete.titleContent,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, top: 50),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: highestPaidJobs.isNotEmpty
              ? Column(
                  children:
                      highestPaidJobs.map((job) => _buildCard(job)).toList(),
                )
              : Text('Tidak ada rekomendasi gaji tinggi'),
        ),
      ],
    );
  }

  Widget _buildCard(Job job) {
    return Container(
      width: 400,
      height: 151,
      child: Card(
        margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        color: ColorPallete.slider,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(job.imageUrl!),
                      radius: 30.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        job.name_perusahaan!,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        job.jobCategory!,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: Text(
                      job.jobType!,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorPallete.titleContent),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          'salary /',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            formatSalaryWithJT('${job.job_salary!.toString()}'),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
