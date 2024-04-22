class ApiClient {
  final String domainName = 'http://10.0.2.2:8000';
  late final String baseUrl;
  ApiClient() {
    baseUrl = '$domainName/api';
  }
}
