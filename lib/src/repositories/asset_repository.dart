import '../services/api_service.dart';
import '../models/location.dart';
import '../models/asset.dart';

class AssetRepository {
  final ApiService apiService;

  AssetRepository({required this.apiService});

  Future<List<Location>> fetchLocations(String companyId) {
    return apiService.fetchLocations(companyId);
  }

  Future<List<Asset>> fetchAssets(String companyId) {
    return apiService.fetchAssets(companyId);
  }
}
