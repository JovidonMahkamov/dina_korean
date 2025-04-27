import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login to your\nAccount",
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.h),
                TextFieldWidget(
                  text: 'Email',
                  prefixIcon: const Icon(
                    IconlyLight.message,
                    color: Colors.grey,
                  ),
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
                SizedBox(height: 20.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            card = !card;
                          });
                        },
                        child:
                            card
                                ? Container(
                                  width: 25.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(
                                      color: Color(0xff335EF7),
                                      width: 3.w,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                                : Container(
                                  width: 25.w,
                                  height: 25.w,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/sign/galichka.png',
                                      ),
                                    ),
                                    border: Border.all(
                                      color: Color(0xff335EF7),
                                      width: 3.w,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                      ),
                      SizedBox(width: 20.w),
                      const Text("Remember me"),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedWidget(
                  onPressed: () {
                    // Navigator.pushNamed(context, RouteNames.bottom_Navbar);
                  },
                  text: 'Sign In',
                ),
                SizedBox(height: 20.h),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, RouteNames.forgotPassword);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Forgot the password"),
                  ),
                ),
                SizedBox(height: 40.h),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSignUpCard(iconUrl: 'assets/sign/facebook.svg'),
                      _buildSignUpCard(iconUrl: 'assets/sign/google.svg'),
                      _buildSignUpCard(iconUrl: 'assets/sign/apple.svg'),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpCard({required String iconUrl}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [SvgPicture.asset(iconUrl, width: 24.w, height: 24.h)],
      ),
    );
  }
}
