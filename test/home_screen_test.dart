import 'package:bloc_test/bloc_test.dart';
import 'package:desafio_tractian/src/blocs/blocs.dart';
import 'package:desafio_tractian/src/blocs/companies_bloc/company_bloc.dart';
import 'package:desafio_tractian/src/blocs/companies_bloc/company_state.dart';
import 'package:desafio_tractian/src/models/company.dart';
import 'package:desafio_tractian/src/screens/home_screen.dart';
import 'package:desafio_tractian/src/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock do CompanyBloc
class MockCompanyBloc extends MockBloc<CompanyEvent, CompanyState>
    implements CompanyBloc {}

void main() {
  late CompanyBloc mockCompanyBloc;

  setUp(() {
    mockCompanyBloc = MockCompanyBloc();
  });

  tearDown(() {
    mockCompanyBloc.close();
  });

  testWidgets('Exibe CircularProgressIndicator quando estado é CompanyLoading',
      (WidgetTester tester) async {
    // mockCompanyBloc.emit(CompanyLoading());
    when(() => mockCompanyBloc.state).thenAnswer((_) => CompanyLoading());
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CompanyBloc>.value(
          value: mockCompanyBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'Exibe lista de CustomElevatedButtonWidget quando estado é CompanyLoaded',
      (WidgetTester tester) async {
    // Emitindo o estado CompanyLoaded com empresas de exemplo
    final sampleCompanies = [
      Company(id: '1', name: 'Company A'),
      Company(id: '2', name: 'Company B'),
    ];
    when(() => mockCompanyBloc.state)
        .thenAnswer((_) => CompanyLoaded(sampleCompanies));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CompanyBloc>.value(
          value: mockCompanyBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Verifica se os botões foram renderizados corretamente
    expect(find.byType(CustomElevatedButtonWidget), findsNWidgets(2));
    expect(find.text('Company A'), findsOneWidget);
    expect(find.text('Company B'), findsOneWidget);
  });

  testWidgets('Exibe SizedBox quando estado é inicial ou desconhecido',
      (WidgetTester tester) async {
    // Emitindo o estado inicial CompanyInitial
    mockCompanyBloc.emit(CompanyInitial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CompanyBloc>.value(
          value: mockCompanyBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Verifica que o SizedBox está presente
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
