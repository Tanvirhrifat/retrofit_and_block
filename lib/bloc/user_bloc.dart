import 'package:bloc/bloc.dart';
import 'package:flutter_retrofit_bloc/api_service.dart';
import 'package:flutter_retrofit_bloc/user.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {}

abstract class UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;

  UsersLoaded(this.users);
}

class UsersError extends UserState {
  final String error;

  UsersError(this.error);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc(this.apiService) : super(UsersLoading()) {
    on<FetchUsers>((event, emit) async {
      try {
        final users = await apiService.getUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });
    add(FetchUsers());
  }
}
