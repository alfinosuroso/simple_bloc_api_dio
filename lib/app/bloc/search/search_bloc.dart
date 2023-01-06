import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_bloc_api_dio/app/model/user.dart';
import 'package:simple_bloc_api_dio/app/repositories/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _repo;

  SearchBloc(this._repo) : super(SearchInitial()) {
    on<SearchUserEvent>((event, emit) async {
      emit((SearchLoading()));
      try {
      final model = await _repo.getSearchUser(event.name);
        emit(SearchLoaded(model));
      } catch (e) {
        debugPrint(e.toString());
        emit(SearchError(e.toString()));
      }
    });
  }
}
