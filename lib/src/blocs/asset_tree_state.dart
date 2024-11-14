import 'package:equatable/equatable.dart';
import '../models/location.dart';
import '../models/asset.dart';

abstract class AssetTreeState extends Equatable {
  const AssetTreeState();

  @override
  List<Object?> get props => [];
}

class AssetTreeInitial extends AssetTreeState {}

class AssetTreeLoading extends AssetTreeState {}

class AssetTreeLoaded extends AssetTreeState {
  final List<Location> locations;
  final List<Asset> assets;

  const AssetTreeLoaded(this.locations, this.assets);

  @override
  List<Object?> get props => [locations, assets];
}

class AssetTreeError extends AssetTreeState {
  final String message;

  AssetTreeError(this.message);

  @override
  List<Object?> get props => [message];
}
