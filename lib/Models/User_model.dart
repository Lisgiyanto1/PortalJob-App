class DummyUser {
  final String photoUrl;
  final String fullName;
  final String email;
  final String password;
  final String skill_tools;
  final String skill_tools2;
  final String skill_tools3;
  final String skill_toolsImg;
  final String skill_toolsImg2;
  final String skill_toolsImg3;
  final String keahlian;
  final String keahlian2;
  final String social_media;
  final String social_media2;
  final String social_media3;

  DummyUser({
    required this.photoUrl,
    required this.fullName,
    required this.email,
    required this.password,
    required this.keahlian,
    required this.keahlian2,
    required this.skill_tools,
    required this.skill_tools2,
    required this.skill_tools3,
    required this.skill_toolsImg,
    required this.skill_toolsImg2,
    required this.skill_toolsImg3,
    required this.social_media,
    required this.social_media2,
    required this.social_media3,
  });
}

// Daftar pengguna dummy
List<DummyUser> dummyUsers = [
  DummyUser(
      photoUrl:
          'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      fullName: 'Lisgiyanto Sofiyan',
      email: 'john.doe@example.com',
      password: 'password123',
      skill_tools: 'Flutter',
      skill_toolsImg:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRztvcotJdGL2Y2aw9VODom93XN2jDQNu8ZtIEdcwGgYw&s',
      skill_tools2: 'React',
      skill_tools3: 'Laravel',
      skill_toolsImg2: '',
      skill_toolsImg3: '',
      social_media: 'https://gitlab.com/lisgiyantosofiyan/bootcampflutter',
      social_media2: 'https://gitlab.com/lisgiyantosofiyan/bootcampflutter',
      social_media3: 'https://gitlab.com/lisgiyantosofiyan/bootcampflutter',
      keahlian: 'Frontend Enginer',
      keahlian2: 'UI Designer')

  // DummyUser(
  //   photoUrl: 'url_gambar_2',
  //   fullName: 'Jane Smith',
  //   email: 'jane.smith@example.com',
  //   password: 'pass123',
  // ),
  // DummyUser(
  //   photoUrl: 'url_gambar_3',
  //   fullName: 'Alice Johnson',
  //   email: 'alice.johnson@example.com',
  //   password: 'alicepass',
  // ),
  // Tambahkan pengguna lain di sini sesuai kebutuhan
];
