import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterly_bloc_auth/application/features/auth/auth_bloc/auth_bloc.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthBloc(),
    child: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xfff263147),
        actions: [
          
          IconButton(onPressed: () {

            final authBloc = BlocProvider.of<AuthBloc>(context);

            authBloc.add(LogoutEvent());

            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

          }, icon: Icon(Icons.logout, color: Colors.white))
        ],
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
