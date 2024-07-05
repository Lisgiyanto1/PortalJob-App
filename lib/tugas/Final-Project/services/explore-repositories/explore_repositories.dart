import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/Models/exploreModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class JobService {
  late Dio _dio;

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'X-RapidAPI-Key': 'a2e3c8b301msh39b9a2f03a1403cp1f76f9jsnb0af96100896',
    'X-RapidAPI-Host': 'arbeitnow-free-job-board.p.rapidapi.com'
  };

  static Dio request = Dio(
    BaseOptions(
      baseUrl: 'https://arbeitnow-free-job-board.p.rapidapi.com',
      headers: headers,
    ),
  );

  Future<List<ExploreJob>> fetchJobs() async {
    try {
      Response response = await request.get('/api/job-board-api');

      if (response.statusCode == 200) {
        final List result = jsonDecode(jsonEncode(response.data))['data'];

        return result.map((e) => ExploreJob.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load jobs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load jobs. Error: $e');
    }
  }
}
