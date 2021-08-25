import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_bloc/user_repository.dart';
import 'package:user_bloc/users_cubit.dart';

import 'user_state.dart';

class UsersView extends StatefulWidget {
  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(SampleUserRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is UsersInitial) {
            return Center(
              child: Column(
                children: [
                  Text("Hello"),
                  FloatingActionButton(
                    onPressed: () => context.read<UsersCubit>().getUsers(),
                    child: Icon(Icons.forward),
                  )
                ],
              ),
            );
          } else if (state is UsersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UsersCompleted) {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(state.response[index].name),
                subtitle: Text(state.response[index].website),
              ),
              itemCount: state.response.length,
            );
          } else {
            final error = state as UsersError;
            return Center(
              child: Text(error.message),
            );
          }
        },
      ),
    );
  }
}
