part of 'job_explore_bloc.dart';

abstract class JobExploreState extends Equatable {}

class JobExploreInitial extends JobExploreState {
  @override
  List<Object?> get props => [];
}

class JobExploreLoading extends JobExploreState {
  @override
  List<Object?> get props => [];
}

class JobExploreLoaded extends JobExploreState {
  final List<ExploreJob> jobs;

  JobExploreLoaded(this.jobs);
  @override
  List<Object?> get props => [jobs];
}

class JobExploreError extends JobExploreState {
  final String error;
  JobExploreError(this.error);

  @override
  List<Object?> get props => [error];
}
