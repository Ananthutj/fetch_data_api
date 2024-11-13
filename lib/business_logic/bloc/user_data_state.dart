part of 'user_data_bloc.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState{}

final class UserDataFailure extends UserDataState{
  final String errorMessage;

  UserDataFailure({
    required this.errorMessage
  });
}

final class UserDataFetched extends UserDataState{
  final List<User> users;
  UserDataFetched({
    required this.users
  });
}
