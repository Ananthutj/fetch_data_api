import 'package:api_fetch_appscrip/business_logic/bloc/user_data_bloc.dart';
import 'package:api_fetch_appscrip/globals/extensions.dart';
import 'package:api_fetch_appscrip/globals/text_styles.dart';
import 'package:api_fetch_appscrip/presentations/screens/Home/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../data/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchText = '';
  late TextEditingController _searchTextController = TextEditingController();
  List<User> _filteredUsers = [];

  Future<void> _refreshUsers() async {
    context.read<UserDataBloc>().add(FetchUserDetails());
  }

  @override
  void initState() {
    _searchTextController = TextEditingController();
    super.initState();
    context.read<UserDataBloc>().add(FetchUserDetails());
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextController.dispose();
  }

  void _updateFilteredUsers() {
    final state = context.read<UserDataBloc>().state;
    if (state is UserDataFetched) {
      if (_searchText.isEmpty) {
        _filteredUsers = state.users;
      } else {
        _filteredUsers = state.users
            .where((user) =>
                user.name.toLowerCase().contains(_searchText.toLowerCase()) ||
                user.email.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade600,
        title: Text(
          "Users",
          style: s3.copyWith(color: context.colorScheme.surface, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 5,
        actions: [
          Icon(
            Icons.person,
            color: context.colorScheme.surface,
          ),
          const Gap(5),
          BlocBuilder<UserDataBloc, UserDataState>(
            builder: (context, state) {
              int userCount = 0;
              if (state is UserDataFetched) {
                userCount = state.users.length;
              }
              return Text(
                userCount.toString(),
                style: s3.copyWith(color: context.colorScheme.surface),
              );
            },
          ),
          const Gap(10),
        ],
      ),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is UserDataFetched) {
            _updateFilteredUsers();
            return RefreshIndicator(
              onRefresh: _refreshUsers,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: _searchTextController,
                          decoration: InputDecoration(
                            hintText: 'Search Users',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _searchText = text;
                              _updateFilteredUsers();
                            });
                          },
                          onTapOutside: (event)=> FocusScope.of(context).unfocus(),
                        ),
                        Positioned(
                            right: 0,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchText = '';
                                      _searchTextController.clear();
                                      
                                    });
                                  },
                                  icon: _searchTextController.text.isNotEmpty ?const Icon(Icons.clear) : const Icon(Icons.search),
                                )),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = _filteredUsers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserDetails(user: user)));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurple.shade600,
                                    Colors.pink.shade600,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 2.5,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  user.name,
                                  style: h3.copyWith(
                                      color: context.colorScheme.surface),
                                ),
                                subtitle: Text(
                                  user.email,
                                  style: s6.copyWith(
                                      color: context.colorScheme.surface),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: context.colorScheme.surface,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserDataLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          } else if (state is UserDataFailure) {
            return const Center(
              child: Text(
                'No users found',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
