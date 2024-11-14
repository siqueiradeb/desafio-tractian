import 'package:desafio_tractian/src/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final ApiService apiService;

  CompanyBloc({required this.apiService}) : super(CompanyInitial()) {
    on<FetchCompanies>(_onFetchCompanies);
  }

  Future<void> _onFetchCompanies(
      FetchCompanies event, Emitter<CompanyState> emit) async {
    emit(CompanyLoading());
    try {
      final companies = await apiService.fetchCompanies();
      emit(CompanyLoaded(companies));
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }
}
