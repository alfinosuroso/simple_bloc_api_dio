part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUserEvent extends SearchEvent {
  final String name;

  const SearchUserEvent(this.name);

  @override
  List<Object> get props => [name];
}
