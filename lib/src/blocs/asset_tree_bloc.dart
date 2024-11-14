import 'package:desafio_tractian/src/models/asset.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/location.dart';
import 'asset_tree_event.dart';
import 'asset_tree_state.dart';
import '../repositories/asset_repository.dart';

class AssetTreeBloc extends Bloc<AssetTreeEvent, AssetTreeState> {
  String _currentCompanyId = '';
  final AssetRepository assetRepository;
  List<Location> _locations = [];

  List<Asset> _assets = [];

  AssetTreeBloc({required this.assetRepository}) : super(AssetTreeInitial()) {
    on<LoadAssetTree>((event, emit) async {
      emit(AssetTreeLoading());
      try {
        _currentCompanyId = event.companyId;
        final locations = await assetRepository.fetchLocations(event.companyId);
        _locations = locations;
        final assets = await assetRepository.fetchAssets(event.companyId);
        _assets = assets;
        emit(AssetTreeLoaded(locations, assets));
      } catch (e) {
        emit(AssetTreeError(e.toString()));
      }
    });

    on<LoadItemsFilterEvent>((event, emit) async {
      emit(AssetTreeLoading());
      if (event.isActive) {
        bool matchesSensorType = false;
        final assets = event.assets ?? _assets;
        final locations = event.locations ?? _locations;
        List<Asset> filteredAssets = assets.where((asset) {
          if (event.searchInput != null && event.searchInput!.isNotEmpty) {
            matchesSensorType = asset.name
                .toLowerCase()
                .contains(event.searchInput!.toLowerCase());
          } else {
            matchesSensorType = event.filterType == 'energy'
                ? asset.sensorType == 'energy'
                : (asset.sensorType == 'vibration' && asset.status == 'alert');
          }
          return matchesSensorType;
        }).toList();

        Set<String> requiredParentIds = {};
        for (var asset in filteredAssets) {
          String? parentId = asset.parentId;
          while (parentId != null) {
            requiredParentIds.add(parentId);
            parentId = assets.firstWhere((a) => a.id == parentId).parentId;
          }
        }

        List<Asset> finalAssets = assets.where((asset) {
          return filteredAssets.contains(asset) ||
              requiredParentIds.contains(asset.id);
        }).toList();

        List<Location> filteredLocations = locations.where((location) {
          return finalAssets.any((asset) => asset.locationId == location.id) ||
              requiredParentIds.contains(location.id);
        }).toList();
        emit(AssetTreeLoaded(filteredLocations, finalAssets));
      } else {
        add(LoadAssetTree(_currentCompanyId));
      }
    });
  }
}
