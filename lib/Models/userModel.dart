import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String email;
  String? photoUrl;
  final String fullName;
  final String password;
  final String skillTools;
  final String skillTools2;
  final String skillTools3;
  final String skillToolsImg;
  final String skillToolsImg2;
  final String skillToolsImg3;
  final String keahlian;
  final String keahlian2;
  final String socialMedia;
  final String socialMedia2;
  final String socialMedia3;

  static UserModel fromUser(UserModel user) {
    return UserModel(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      password: user.password,
      photoUrl: user.photoUrl,
      skillTools: user.skillTools,
      skillTools2: user.skillTools2,
      skillTools3: user.skillTools3,
      skillToolsImg: user.skillToolsImg,
      skillToolsImg2: user.skillToolsImg2,
      skillToolsImg3: user.skillToolsImg3,
      keahlian: user.keahlian,
      keahlian2: user.keahlian2,
      socialMedia: user.socialMedia,
      socialMedia2: user.socialMedia2,
      socialMedia3: user.socialMedia3,
    );
  }

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.keahlian,
    required this.keahlian2,
    required this.skillTools,
    required this.skillTools2,
    required this.skillTools3,
    required this.skillToolsImg,
    required this.skillToolsImg2,
    required this.skillToolsImg3,
    required this.socialMedia,
    required this.socialMedia2,
    required this.socialMedia3,
    this.photoUrl = "", // Tambahkan nilai default untuk properti opsional
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'photoUrl': photoUrl,
      'skillTools': skillTools,
      'skillTools2': skillTools2,
      'skillTools3': skillTools3,
      'skillToolsImg': skillToolsImg,
      'skillToolsImg2': skillToolsImg2,
      'skillToolsImg3': skillToolsImg3,
      'keahlian': keahlian,
      'keahlian2': keahlian2,
      'socialMedia': socialMedia,
      'socialMedia2': socialMedia2,
      'socialMedia3': socialMedia3,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      email: data['email'],
      fullName: data['fullName'],
      photoUrl: data['photoUrl'],
      skillTools: data['skillTools'],
      skillTools2: data['skillTools2'],
      skillTools3: data['skillTools3'],
      skillToolsImg: data['skillToolsImg'],
      skillToolsImg2: data['skillToolsImg2'],
      skillToolsImg3: data['skillToolsImg3'],
      keahlian: data['keahlian'],
      keahlian2: data['keahlian2'],
      socialMedia: data['socialMedia'],
      socialMedia2: data['socialMedia2'],
      socialMedia3: data['socialMedia3'],
      password: '',
    );
  }
}
