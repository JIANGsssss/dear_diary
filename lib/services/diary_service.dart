import 'package:dear_diary/utils/api_helper.dart';
import 'package:dear_diary/utils/auth_helper.dart';
import 'package:http/http.dart' show Client, Response;

class DiaryService {
  // TODO: Use DI to provide token, since it will be used for virtually all calls here
  final Client apiClient = Client();
  static const _baseUrl = BASE_URL;

  Future<Response> getEntries() async {
    final String url = '$_baseUrl/entries';
    final String token = await AuthHelper.getUserToken();
    return apiClient.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
  }

  Future<Response> addEntry(Map<String, String> entry) async {
    final String url = '$_baseUrl/entries';
    final String token = await AuthHelper.getUserToken();
    return apiClient.post(url, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'title': entry['title'],
      'content': entry['content']
    });
  }

  Future<Response> updateEntry(Map<String, dynamic> entry) async {
    print('${entry['id']}');
    final String url = '$_baseUrl/entries/${entry['id']}';
    final String token = await AuthHelper.getUserToken();
    return apiClient.put(url, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'title': entry['title'],
      'content': entry['content']
    });
  }
}
