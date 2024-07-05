import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:flutter_app/tugas/Final-Project/widget/job_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/tugas/Final-Project/services/explore-repositories/explore_repositories.dart';
import 'package:flutter_app/tugas/Final-Project/bloc/explore_bloc/job_explore_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late TextEditingController _searchController;
  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              JobExploreBloc(jobRepository: JobService())
                ..add(LoadJobExploreEvent()),
        ),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search jobs...',
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(12),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _selectedTags.clear();
                                // Add any additional logic here for clearing the search results
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _getTags(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<JobExploreBloc, JobExploreState>(
              builder: (context, state) {
                if (state is JobExploreLoading) {
                  return SliverFillRemaining(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is JobExploreLoaded) {
                  // Filter jobs based on search query and selected tags
                  final searchQuery = _searchController.text.toLowerCase();
                  final filteredJobs = state.jobs
                      .where((job) =>
                          job.title.toLowerCase().contains(searchQuery) &&
                          (_selectedTags.isEmpty ||
                              _selectedTags
                                  .any((tag) => job.tags.contains(tag))))
                      .toList();

                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 4 / 2.5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final job = filteredJobs[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobDetailPage(job: job),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 20,
                                  left: 20,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job.companyName.length > 20
                                            ? '${job.companyName.substring(0, 20)}...'
                                            : job.companyName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          Flexible(
                                            child: Text(
                                              job.location,
                                              style: TextStyle(fontSize: 13),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        job.description
                                                .replaceAll(
                                                    RegExp(r'<[^>]*>',
                                                        multiLine: true),
                                                    '')
                                                .trim()
                                                .split(' ')
                                                .take(10)
                                                .join(' ')
                                                .trim() +
                                            '...',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: job.tags.length > 1
                                                ? Row(
                                                    children: [
                                                      ...job.tags
                                                          .take(1)
                                                          .map(
                                                            (tag) => Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // Rounded corners
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width:
                                                                        1), // Border color
                                                              ),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 20,
                                                                      right:
                                                                          10),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 10,
                                                                      left: 10,
                                                                      top: 2,
                                                                      bottom:
                                                                          2),
                                                              child: Text(
                                                                tag.length > 2
                                                                    ? '${tag.substring(0, 2)}...'
                                                                    : tag,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // Rounded corners
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width:
                                                                  1), // Border color
                                                          color: ColorPallete
                                                              .linkText,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: 20, right: 10),
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10,
                                                                left: 10,
                                                                top: 2,
                                                                bottom: 2),
                                                        child: Text("more..."),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: job.tags
                                                        .map(
                                                          (tag) => Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10), // Rounded corners
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width:
                                                                      1), // Border color
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 20,
                                                                    right: 10),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10,
                                                                    left: 10,
                                                                    top: 2,
                                                                    bottom: 2),
                                                            child: Text(
                                                              tag.length > 20
                                                                  ? '${tag.substring(0, 20)}...'
                                                                  : tag,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: min(3, filteredJobs.length),
                    ),
                  );
                } else if (state is JobExploreError) {
                  return SliverFillRemaining(
                    child: Center(child: Text(state.error)),
                  );
                } else {
                  return SliverFillRemaining(
                    child: Center(child: Text('Unknown state')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getTags() {
    final tags = [
      'Remote',
      'Manager',
      'Customer Service',
    ];

    return tags
        .map((tag) => GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectedTags.contains(tag)) {
                    _selectedTags.remove(tag);
                  } else {
                    _selectedTags.add(tag);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedTags.contains(tag)
                      ? ColorPallete.linkText
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: _selectedTags.contains(tag)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ))
        .toList();
  }
}
