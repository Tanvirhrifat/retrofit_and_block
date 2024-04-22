import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_retrofit_bloc/bloc/user_bloc.dart';
import 'api_service.dart';
// import 'user.dart';
import 'package:dio/dio.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiService = ApiService(dio);

    return BlocProvider(
      create: (context) => UserBloc(apiService)..add(FetchUsers()),
      child: Scaffold(
        appBar: AppBar(title: Text("Users"),centerTitle: true,),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UsersError) {
              return Center(child: Text("Error: ${state.error}"));
            } else if (state is UsersLoaded) {
              final users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              );
            } else {
              return Center(child: Text("Unknown state"));
            }
          },
        ),
      ),
    );
  }
}
