import 'package:desafio_tractian/src/blocs/asset_tree_bloc.dart';
import 'package:desafio_tractian/src/blocs/asset_tree_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: SearchBar(
        leading: const Icon(Icons.search),
        hintText: 'Buscar Ativos ou Local',
        shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
        onChanged: (value) {
          context.read<AssetTreeBloc>().add(LoadItemsFilterEvent(
                searchInput: value,
                isActive: value.isEmpty ? false : true,
              ));
        },
      ),
    );
  }
}
