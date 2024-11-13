import 'package:api_fetch_appscrip/business_logic/bloc/user_data_bloc.dart';
import 'package:api_fetch_appscrip/globals/text_styles.dart';
import 'package:api_fetch_appscrip/presentations/screens/Home/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> _refreshUsers() async {
    context.read<UserDataBloc>().add(FetchUserDetails());
  }

  @override
  void initState() {
    super.initState();
    context.read<UserDataBloc>().add(FetchUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text(
          "Users",
          style: s3.copyWith(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is UserDataFetched) {
            return RefreshIndicator(
              onRefresh: _refreshUsers,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetails(user: user)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.teal.shade600,
                                Colors.teal.shade800,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2.5,
                                offset:const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              user.name,
                              style: h3.copyWith(color: Colors.white)
                            ),
                            subtitle: Text(
                              user.email,
                              style:h4.copyWith(color: Colors.white)
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is UserDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is UserDataFailure){
            return const Center(
              child: Text('No users found'),
            );
          }
          else{
            return const Center(child: Text("Something went wrong"),);
          }
        },
      ),
    );
  }
}
