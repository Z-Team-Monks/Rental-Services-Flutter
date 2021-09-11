import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/network.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:equatable/equatable.dart';

enum UserAuthState { LOGGEDIN, LOGGEDIN_ADMIN, LOGGEDOUT, CHECKING }

abstract class UserAuthEvent extends Equatable {
  const UserAuthEvent();

  @override
  List<Object> get props => [];
}

class UserAuthChanged extends UserAuthEvent {
  const UserAuthChanged({required this.exists});

  final bool exists;

  @override
  List<Object> get props => [exists];
}

class UserStatusChecking extends UserAuthEvent {}

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final AuthRepository authRepository;
  UserAuthBloc({required this.authRepository}) : super(UserAuthState.CHECKING);

  @override
  Stream<UserAuthState> mapEventToState(UserAuthEvent event) async* {
    if (event is UserStatusChecking) {
      yield UserAuthState.CHECKING;
      final user = authRepository.readToken(key: "token");
      if (user.isLeft()) {
        yield UserAuthState.LOGGEDOUT;
      } else {
        print("user token is: ${user.getOrElse(() => "invalid token")}");
        final isAdminCheck = await authRepository.checkIsAdmin();

        AppConstants.token = user.getOrElse(() => "") ?? "";

        if (isAdminCheck.isLeft()) yield UserAuthState.LOGGEDOUT;
        bool isAdmin = isAdminCheck.getOrElse(() => false);

        if (isAdmin) {
          print("logged in as an admin");
          yield UserAuthState.LOGGEDIN_ADMIN;
        } else {
          print("logged in as an normal user");
          yield UserAuthState.LOGGEDIN;
        }
      }
    }
  }
}
