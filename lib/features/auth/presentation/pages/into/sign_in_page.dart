import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../../core/di/services.dart';
import '../../../../../core/route/route_names.dart';
import '../../../../../core/untils/logger.dart';
import '../../../data/datasource/local/auth_local_data_source.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/log_in/log_in_bloc.dart';
import '../../bloc/log_in/log_in_state.dart';
import '../../widgets/elevated_widget.dart';
import '../../widgets/text_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authLocalDataSource = sl<AuthLocalDataSource>();
  bool card = true;
  bool eye = true;
  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
  void signInUser() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    BlocProvider.of<LogInUserBloc>(
      context,
    ).add(LoginUser(email: email, password: password));
  }
  void saveRememberMe(String email, String password) {
    authLocalDataSource
        .saveRememberMe(email, password)
        .then((_) {
      LoggerService.info("Remember Me saved : $email - $password");
    })
        .catchError((error) {
      LoggerService.error("Error saving Remember Me: $error");
    });
  }
  void saveAuthToken(String token,) {
    authLocalDataSource
        .saveAuthToken(token)
        .then((_) {
      LoggerService.info("Auth Token saved : $token");
    })
        .catchError((error) {
      LoggerService.error("Error saving Auth Token: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 200.h),
              Text(
                "Login to your\nAccount",
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),
              TextFieldWidget(
                text: 'Login',
                prefixIcon: const Icon(IconlyLight.message, color: Colors.grey),
                textEditingController: emailController,
                obscureText: false,
              ),
              SizedBox(height: 10.h),
              TextFieldWidget(
                text: 'Password',
                prefixIcon: const Icon(IconlyLight.lock, color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      eye = !eye;
                    });
                  },
                  icon: Icon(eye ? IconlyLight.hide : IconlyLight.show),
                ),
                textEditingController: passwordController,
                obscureText: eye,
              ),
              Expanded(
                child: SizedBox(//height: 250.h
                ),
              ),
              BlocConsumer<LogInUserBloc, LogInUserState>(
                listener: (context, state) {
                  if (state is LogInUserSuccess) {
                    saveRememberMe(
                      emailController.text,
                      passwordController.text,
                    );
                    saveAuthToken(state.user.token,);
                    Navigator.pushReplacementNamed(context, RouteNames.bottomNavBar);
                  } else if (state is LogInUserError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LogInUserLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballSpinFadeLoader,
                          colors: [Colors.blueAccent],
                          strokeWidth: 2,
                        ),
                      ),);
                  } else {
                    return ElevatedWidget(
                      text: "Sign In",
                      onPressed: signInUser,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
