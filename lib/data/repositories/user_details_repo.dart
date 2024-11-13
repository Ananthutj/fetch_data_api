import 'package:api_fetch_appscrip/data/models/user.dart';
import 'package:api_fetch_appscrip/data/services/user_details_services.dart';

class UserDetailsRepo {
  final UserDetailsServices userDetailsServices = UserDetailsServices();

  Future<List<User>> fetchUser() async{
    final data = await userDetailsServices.fetchUserDetails();
    return data.map((user)=> User.fromJson(user)).toList();
  }
}