// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/space_item.dart';

class ApiService {
  static const String baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  Future<List<SpaceItem>> getItems(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => SpaceItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<SpaceItem> getItemDetail(String endpoint, int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint/$id/'));

    if (response.statusCode == 200) {
      return SpaceItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load item detail');
    }
  }
}
