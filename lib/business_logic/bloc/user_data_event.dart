part of 'user_data_bloc.dart';

@immutable
sealed class UserDataEvent {}

class FetchUserDetails extends UserDataEvent{}