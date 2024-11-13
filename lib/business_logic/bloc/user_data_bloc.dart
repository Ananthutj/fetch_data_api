import 'package:api_fetch_appscrip/data/models/user.dart';
import 'package:api_fetch_appscrip/data/repositories/user_details_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UserDetailsRepo userDetailsRepo;
  UserDataBloc(this.userDetailsRepo) : super(UserDataInitial()) {
    on<FetchUserDetails>(_manageFetchUserDetails);
  }
  Future<void> _manageFetchUserDetails(FetchUserDetails event, Emitter<UserDataState> emit) async{
    try {
      emit(UserDataLoading());
      final users = await userDetailsRepo.fetchUser();
      emit(UserDataFetched(users: users));
    } catch (e) {
      emit(UserDataFailure(errorMessage: 'Failed to fetch the user data'));
    }
  }
}
