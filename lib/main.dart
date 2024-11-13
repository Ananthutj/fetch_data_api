import 'package:api_fetch_appscrip/business_logic/bloc/user_data_bloc.dart';
import 'package:api_fetch_appscrip/data/repositories/user_details_repo.dart';
import 'package:api_fetch_appscrip/presentations/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const AppScrip());
}

class AppScrip extends StatelessWidget {
  const AppScrip({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetailsRepo userDetailsRepo = UserDetailsRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> UserDataBloc(userDetailsRepo))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:const HomeScreen(),
      ),
    );
  }
}
