part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class GetUserByIdEvent extends UserEvent {
  final String id;

  const GetUserByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
