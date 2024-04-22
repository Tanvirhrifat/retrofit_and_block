import 'package:flutter_retrofit_bloc/user.dart';

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
