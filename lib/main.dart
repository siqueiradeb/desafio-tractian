import 'package:desafio_tractian/src/blocs/asset_tree_bloc.dart';
import 'package:desafio_tractian/src/repositories/asset_repository.dart';
import 'package:desafio_tractian/src/screens/home_screen.dart';
import 'package:desafio_tractian/src/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/blocs/blocs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AssetTreeBloc(
            assetRepository: AssetRepository(apiService: ApiService()),
          ),
        ),
        BlocProvider(
          create: (context) =>
              CompanyBloc(apiService: ApiService())..add(FetchCompanies()),
        ),
      ],
      child: MaterialApp(
        title: 'Asset Tree App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
