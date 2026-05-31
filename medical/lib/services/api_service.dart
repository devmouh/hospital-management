class ApiService {
  // Use 192.168.100.68:8000 for wireless Wi-Fi connection.
  static const String baseUrl = 'http://192.168.100.68:8000';

  static String? accessToken;

  static Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
  }
}
