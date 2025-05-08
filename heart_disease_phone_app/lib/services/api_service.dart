import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  static const String _baseUrl =
      'https://racial-celine-dot98889-fd93329a.koyeb.app';

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
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
      final requestData = {
        'Age': age,
        'Sex': sex,
        'Chest pain type': chestPainType,
        'BP': bp,
        'Cholesterol': cholesterol,
        'FBS over 120': fbsOver120,
        'EKG results': ekgResults,
        'Max HR': maxHr,
        'Exercise angina': exerciseAngina,
        'ST depression': stDepression,
        'Slope of ST': slopeOfSt,
        'Number of vessels fluro': numberOfVesselsFluro,
        'Thallium': thallium,
      };

      print('Request Data: $requestData');

      final response = await _dio.post(
        '/predict',
        data: requestData,
        options: Options(
          validateStatus: (status) => status! < 500, // Accept 400 responses
        ),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return _parseSuccessResponse(response.data);
      } else if (response.statusCode == 400) {
        return _parse400Error(response.data);
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return _parse400Error(e.response?.data);
      }
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected Error: $e');
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
