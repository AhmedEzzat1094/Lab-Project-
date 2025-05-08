import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  static const String _baseUrl =
      'https://racial-celine-dot98889-fd93329a.koyeb.app';

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
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
      // Use the exact parameter names that your API expects
      final requestData = {
        "age": 20,
        "sex": 1,
        "chest_pain_type": 2,
        "bp": 130,
        "cholesterol": 100,
        "fbs_over_120": 0,
        "ekg_results": 1,
        "max_hr": 150,
        "exercise_angina": 0,
        "st_depression": 1.2,
        "slope_of_st": 2,
        "number_of_vessels_fluro": 1,
        "thallium": 3
      };

      print('Sending request with data: $requestData');

      final response = await _dio.post(
        '/predict',
        data: requestData,
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      print('Received response: ${response.data}');

      if (response.statusCode == 200) {
        return _parseSuccessResponse(response.data);
      } else if (response.statusCode == 400) {
        return _parse400Error(response.data);
      } else {
        throw Exception('API error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
        if (e.response?.statusCode == 400) {
          return _parse400Error(e.response?.data);
        }
      }
      throw Exception('Failed to connect to API: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Map<String, dynamic> _parseSuccessResponse(dynamic data) {
    if (data is! Map) {
      throw Exception('Invalid response format');
    }

    return {
      'hasDisease': data['prediction'] == 1,
      'message': data['message'] ??
          (data['prediction'] == 1 ? 'High risk detected' : 'No risk detected'),
      'probability': data['probability']?.toDouble(),
      'error': false,
    };
  }

  Map<String, dynamic> _parse400Error(dynamic errorData) {
    String errorMessage = 'Invalid request';

    if (errorData is Map) {
      errorMessage = errorData['message'] ??
          errorData['error'] ??
          errorData['detail'] ??
          'Please check your input values';
    } else if (errorData is String) {
      errorMessage = errorData;
    }

    return {
      'error': true,
      'message': errorMessage,
      'hasDisease': false,
      'probability': 0.0,
    };
  }
}
