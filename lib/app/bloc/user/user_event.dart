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

class PostUserEvent extends UserEvent {
  final String name;
  final String gender;
  final String email;
  final String status;

  const PostUserEvent(this.name, this.gender, this.email, this.status);

  @override
  List<Object> get props => [name, gender, email, status];
}

class UpdateUserEvent extends UserEvent {
  final int id;
  final String name;
  final String email;
  final String status;

  const UpdateUserEvent(this.id, this.name, this.email, this.status);

  @override
  List<Object> get props => [id, name, email, status];
}

class DeleteUserEvent extends UserEvent {
  final String id;

  const DeleteUserEvent(this.id);

  @override
  List<Object> get props => [id];
}
