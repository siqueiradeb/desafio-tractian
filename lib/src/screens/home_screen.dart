import 'package:desafio_tractian/src/blocs/companies_bloc/company_bloc.dart';
import 'package:desafio_tractian/src/blocs/companies_bloc/company_state.dart';
import 'package:desafio_tractian/src/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF17192D),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<CompanyBloc, CompanyState>(
            builder: (context, state) {
              if (state is CompanyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CompanyLoaded) {
                return Column(
                  children: [
                    ...state.companies.map(
                      (company) => CustomElevatedButtonWidget(
                          label: company.name, companyId: company.id),
                    )
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
