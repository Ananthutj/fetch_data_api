import 'dart:convert';

import 'package:http/http.dart' as http;

class UserDetailsServices {
  Future<List<dynamic>> fetchUserDetails() async{
    String url = 'https://jsonplaceholder.typicode.com/users';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return json.decode(response.body) as List<dynamic>;
    }
    else{
      throw 'Failed to load the user data';
    }
  }

}