import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  static const String _baseUrl = ' https://racial-celine-dot98889-fd93329a.koyeb.app/'; 

  ApiService() : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout:const  Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        ));

  Future<Map<String, dynamic>> predictHeartDisease({
    required int age,
    required int sex,
    required int chestPainType,
    required int bp,
    required int cholesterol,
    required int fbsOver120,
    required int ekgResults,
    required int maxHr,
    required int exerciseAngina,
    required double stDepression,
    required int slopeOfSt,
    required int numberOfVesselsFluro,
    required int thallium,
  }) async {
    try {
      final response = await _dio.post(
        '',
        data: {
          'age': age,
          'sex': sex,
          'chest_pain_type': chestPainType,
          'bp': bp,
          'cholesterol': cholesterol,
          'fbs_over_120': fbsOver120,
          'ekg_results': ekgResults,
          'max_hr': maxHr,
          'exercise_angina': exerciseAngina,
          'st_depression': stDepression,
          'slope_of_st': slopeOfSt,
          'number_of_vessels_fluro': numberOfVesselsFluro,
          'thallium': thallium,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey('prediction') && data.containsKey('probability')) {
          return {
            'prediction': data['prediction'],
            'probability': data['probability'],
          };
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('API error: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}