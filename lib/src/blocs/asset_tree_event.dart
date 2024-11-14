import 'package:desafio_tractian/src/models/asset.dart';
import 'package:desafio_tractian/src/models/location.dart';
import 'package:equatable/equatable.dart';

abstract class AssetTreeEvent extends Equatable {
  const AssetTreeEvent();

  @override
  List<Object?> get props => [];
}

class LoadAssetTree extends AssetTreeEvent {
  final String companyId;

  LoadAssetTree(this.companyId);

  @override
  List<Object?> get props => [companyId];
}

class LoadItemsFilterEvent extends AssetTreeEvent {
  final List<Location>? locations;
  final List<Asset>? assets;
  final bool isActive;
  final String? filterType;
  final String? searchInput;
  const LoadItemsFilterEvent(
      {this.locations,
      this.assets,
      this.isActive = false,
      this.filterType,
      this.searchInput});

  @override
  List<Object?> get props =>
      [locations, assets, isActive, filterType, searchInput];
}
