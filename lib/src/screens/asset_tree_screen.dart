import 'package:desafio_tractian/src/models/location.dart';
import 'package:desafio_tractian/src/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/asset_tree_bloc.dart';
import '../blocs/asset_tree_event.dart';
import '../blocs/asset_tree_state.dart';
import '../models/asset.dart';

// ignore: must_be_immutable
class AssetTreeScreen extends StatelessWidget {
  final String companyId;

  AssetTreeScreen({super.key, required this.companyId});

  List<Location> _locations = [];

  List<Asset> _assets = [];

  bool isEnergyFilterApplied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assets')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchBarWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilterTagWidget(
                iconData: Icons.flash_on,
                label: 'Sensor de Energia',
                onPressed: () {
                  isEnergyFilterApplied = !isEnergyFilterApplied;
                  context.read<AssetTreeBloc>().add(LoadItemsFilterEvent(
                      assets: _assets,
                      locations: _locations,
                      isActive: isEnergyFilterApplied,
                      filterType: 'energy'));
                },
              ),
              FilterTagWidget(
                iconData: Icons.warning,
                label: 'Critico',
                onPressed: () {
                  isEnergyFilterApplied = !isEnergyFilterApplied;
                  context.read<AssetTreeBloc>().add(LoadItemsFilterEvent(
                      assets: _assets,
                      locations: _locations,
                      isActive: isEnergyFilterApplied,
                      filterType: 'critico'));
                },
              ),
            ],
          ),
          BlocBuilder<AssetTreeBloc, AssetTreeState>(
            builder: (context, state) {
              if (state is AssetTreeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AssetTreeLoaded) {
                _locations = state.locations;
                _assets = state.assets;
                return TreeItemWidget(
                  locations: state.locations,
                  assets: state.assets,
                );
              } else if (state is AssetTreeError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
