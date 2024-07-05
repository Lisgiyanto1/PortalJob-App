import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/Models/exploreModel.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailPage extends StatefulWidget {
  final ExploreJob job;

  JobDetailPage({required this.job});

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late ScrollController _scrollController;
  ColorTween _appBarColorTween =
      ColorTween(begin: Colors.white, end: Colors.blue);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (!_scrollController.hasClients) return;
        double offset = _scrollController.offset;
        if (offset > 0) {
          _appBarColorTween.end =
              Colors.blue.withAlpha((255 * offset / 100).toInt());
        } else {
          _appBarColorTween.end = Colors.white;
        }
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: NestedScrollView(
          controller: _scrollController, // Attach the ScrollController here
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 200.0,
                pinned: true,
                backgroundColor: ColorPallete
                    .primaryColor, // Prevent the SliverAppBar from collapsing
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.job.title.length > 30
                        ? '${widget.job.title.substring(0, 30)}...'
                        : widget.job.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  background: Image.network(
                    'https://picsum.photos/id/1015/1000/600',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job.companyName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Flexible(
                      child: Text(
                        widget.job.location,
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        widget.job.description
                                .replaceAll(
                                    RegExp(r'<[^>]*>', multiLine: true), '')
                                .trim()
                                .split(' ')
                                .join(' ')
                                .trim() +
                            '...',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorPallete.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.web,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle the button tap event here
                            launch(widget.job.url);
                          },
                          child: Center(
                            child: Text(
                              'Visit Website',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
