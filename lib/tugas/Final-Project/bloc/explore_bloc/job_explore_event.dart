part of 'job_explore_bloc.dart';

abstract class JobExploreEvent extends Equatable {
  const JobExploreEvent();
}

class LoadJobExploreEvent extends JobExploreEvent {
  @override
  List<Object?> get props => [];
}
