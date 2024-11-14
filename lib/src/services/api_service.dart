import 'dart:convert';
import 'package:desafio_tractian/src/models/asset.dart';
import 'package:desafio_tractian/src/models/company.dart';
import 'package:desafio_tractian/src/models/location.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://fake-api.tractian.com';

  Future<List<Location>> fetchLocations(String companyId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/companies/$companyId/locations'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map(
        (e) {
          return Location.fromJson(e);
        },
      ).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<List<Asset>> fetchAssets(String companyId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/companies/$companyId/assets'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Asset.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load assets');
    }
  }

  Future<List<Company>> fetchCompanies() async {
    final response = await http.get(Uri.parse('$baseUrl/companies'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Company.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load companies');
    }
  }
}
