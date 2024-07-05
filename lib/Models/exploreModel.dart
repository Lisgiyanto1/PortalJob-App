class ExploreJob {
  final String slug;
  final String companyName;
  final String title;
  final String description;
  final bool remote;
  final String url;
  final List<String> tags;
  final List<String> jobTypes;
  final String location;
  final int createdAt;

  ExploreJob({
    required this.slug,
    required this.companyName,
    required this.title,
    required this.description,
    required this.remote,
    required this.url,
    required this.tags,
    required this.jobTypes,
    required this.location,
    required this.createdAt,
  });

  factory ExploreJob.fromJson(Map<String, dynamic> json) {
    return ExploreJob(
      slug: json['slug'],
      companyName: json['company_name'],
      title: json['title'],
      description: json['description'],
      remote: json['remote'],
      url: json['url'],
      tags: List<String>.from(json['tags']),
      jobTypes: List<String>.from(json['job_types']),
      location: json['location'],
      createdAt: json['created_at'],
    );
  }
}
