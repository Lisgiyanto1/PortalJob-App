class Job {
  final String? imageUrl;
  final String? name_perusahaan;
  final String? jobType;
  final String? jobCategory;
  final double? job_salary;
  final int? job_experience;

  Job({
    this.imageUrl,
    this.name_perusahaan,
    this.jobType,
    this.jobCategory,
    this.job_salary,
    this.job_experience,
  });
}

final List<Job> jobs = [
  Job(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Figma-logo.svg/1667px-Figma-logo.svg.png',
    name_perusahaan: 'Figma Collection',
    jobType: 'Fulltime',
    jobCategory: 'UI Designer',
    job_salary: 10000000.00,
    job_experience: 1,
  ),
  Job(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Adobe_Illustrator_CC_icon.svg/2101px-Adobe_Illustrator_CC_icon.svg.png',
    name_perusahaan: 'Adobe XD Studio',
    jobType: 'Freelance',
    jobCategory: 'UX Designer',
    job_salary: 12000000,
    job_experience: 2,
  ),
  Job(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
    name_perusahaan: 'Sketch Inc.',
    jobType: 'Freelance',
    jobCategory: 'Product Designer',
    job_salary: 800000000,
    job_experience: 0,
  ),
  Job(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
    name_perusahaan: 'Meta',
    jobType: 'Fulltime',
    jobCategory: 'Fullstack Developer',
    job_salary: 100000000,
    job_experience: 1,
  ),
];
