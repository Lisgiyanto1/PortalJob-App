import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Models/exploreModel.dart';
import 'package:flutter_app/tugas/Final-Project/services/explore-repositories/explore_repositories.dart';
import 'package:meta/meta.dart';

part 'job_explore_event.dart';
part 'job_explore_state.dart';

class JobExploreBloc extends Bloc<JobExploreEvent, JobExploreState> {
  final JobService _jobRepository;

  JobExploreBloc({required JobService jobRepository})
      : _jobRepository = jobRepository,
        super(JobExploreInitial()) {
    on<LoadJobExploreEvent>((event, emit) async {
      try {
        emit(JobExploreLoading());
        final List<ExploreJob> jobs = await _jobRepository.fetchJobs();
        emit(JobExploreLoaded(jobs));
      } catch (e) {
        emit(JobExploreError(e.toString()));
      }
    });
  }
}
