import 'package:desafio_tractian/src/blocs/asset_tree_bloc.dart';
import 'package:desafio_tractian/src/blocs/asset_tree_event.dart';
import 'package:desafio_tractian/src/screens/asset_tree_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final String? label;
  final String? companyId;
  const CustomElevatedButtonWidget({
    super.key,
    required this.label,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      child: SizedBox(
        width: 400,
        height: 90,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<AssetTreeBloc>(context)
                    ..add(LoadAssetTree(companyId ?? '')),
                  child: AssetTreeScreen(companyId: companyId ?? ''),
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(
                vertical: 16), // Aumenta o padding interno vertical
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  5), // Bordas arredondadas de acordo com o Figma
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icon.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Text(
                label ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 28 / 18,
                  // fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
