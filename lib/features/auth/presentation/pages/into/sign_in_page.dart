import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/route/route_names.dart';
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
  bool card = true;
  bool eye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                text: 'Email',
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
                child: SizedBox(),
              ),
              ElevatedWidget(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.bottomNavBar);
                },
                text: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
