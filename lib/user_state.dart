import 'package:flutter/foundation.dart';

import 'package:user_bloc/users.dart';

abstract class UsersState {
  const UsersState();
}

class UsersInitial extends UsersState {
  const UsersInitial();
}

class UsersLoading extends UsersState {
  const UsersLoading();
}

class UsersCompleted extends UsersState {
  final List<Users> response;
  const UsersCompleted(this.response);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersCompleted && listEquals(other.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class UsersError extends UsersState {
  final String message;
  const UsersError(this.message);
}
