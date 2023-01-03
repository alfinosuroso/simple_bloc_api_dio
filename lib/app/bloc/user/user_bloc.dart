import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_bloc_api_dio/app/model/user.dart';
import 'package:simple_bloc_api_dio/app/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repo;

  UserBloc(this._repo) : super(UserInitial()) {
    on<GetAllUserEvent>((event, emit) async {
      try {
        emit(UserLoading());
        final model = await _repo.getAllUser();
        emit(UserLoaded(model));
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });

    on<GetUserByIdEvent>((event, emit) async {
      try {
        emit(UserLoading());
        final model = await _repo.getUserById(event.id);
        emit(UserDetailLoaded(model));
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });
  }
}
