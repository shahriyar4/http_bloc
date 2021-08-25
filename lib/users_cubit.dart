import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_bloc/user_repository.dart';

import 'user_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UserRepository _userRepository;
  UsersCubit(this._userRepository) : super(UsersInitial());

  void getUsers() async {
    try {
      emit(UsersLoading());

      Future.delayed(Duration(milliseconds: 500));
      final response = await _userRepository.getCats();
      emit(UsersCompleted(response));
    } on NetworkError catch (e) {
      emit(UsersError(e.messsage));
    }
  }
}
