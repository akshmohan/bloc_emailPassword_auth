import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterly_bloc_auth/application/features/auth/auth_bloc/auth_bloc.dart';
import 'package:flutterly_bloc_auth/application/features/auth/widgets/custom_text_form_field.dart';


class LoginViewWrapper extends StatelessWidget {
  const LoginViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthBloc(), child: LoginPage());
  }
}



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {

      if(state is AuthLoading){

        return Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        );

      }

      if (state is Authenticated) {

        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        });
      }
      
      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login with E-mail",
                  style: Theme.of(context).textTheme.displayLarge),
              SizedBox(height: 20),
              CustomTextFormField(
                  controller: _emailController, hintText: 'Enter E-mail'),
              SizedBox(height: 20),
              CustomTextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  hintText: 'Enter Password'),
              SizedBox(height: 20),
              InkResponse(
                onTap: () {

                  authBloc.add(LoginEvent(email: _emailController.text.trim(), password: _passwordController.text.trim()));

                },
                child: Container(
                  height: 52.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.orange,
                  ),
                  child: Center(
                    child:
                    Text("Login", style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New here?", style: Theme.of(context).textTheme.bodySmall),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text("Register",
                          style: Theme.of(context).textTheme.bodySmall))
                ],
              )
            ],
          ),
        ),
      );

    });
  }
}
