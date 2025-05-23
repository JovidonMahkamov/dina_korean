import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/route/route_names.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../../bloc/profile_event.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileE());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: [Colors.blueAccent],
                    strokeWidth: 2.w,
                  ),
                ),
              );
            } else if (state is ProfileSuccess) {
              final user = state.profile;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/profile/nature.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: SizedBox(
                              height: 55.h,
                              width: 170.w,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final updatedProfile =
                                      await Navigator.pushNamed(
                                        context,
                                        RouteNames.editProfile,
                                        arguments: user,
                                      );
                                  if (updatedProfile != null) {
                                    context.read<ProfileBloc>().add(
                                      ProfileE(),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 7),
                                    Text('Tahrirlash'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -75,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/profile/profile.jpg',
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100.h),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'student',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      _infoRow('Guruh', Icons.groups, user.groupName),
                      SizedBox(height: 40.h),
                      _infoRow('Foydalanuvchi Nomi', Icons.person, user.login),
                      SizedBox(height: 40.h),
                      _infoRow(
                        'Telegram ID',
                        FontAwesomeIcons.link,
                        user.telegramId,
                      ),
                      SizedBox(height: 40.h),
                      _infoRow('Telefon raqam', Icons.phone, user.phone),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Icon(IconlyBold.logout, color: Colors.red),
                          TextButton(
                            onPressed: ()  {
                              showSuccessDialog(context);
                            },
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("Noma’lum holat"));
            }
          },
        ),
      ),
    );
  }

  Widget _infoRow(String label, IconData icon, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        Row(
          children: [
            Icon(icon, size: 30),
            SizedBox(width: 15.w),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp),
            ),
          ],
        ),
      ],
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Accountdan chiqmoqchimisiz ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                         ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Yo'q"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child:
                         ElevatedButton(
                          onPressed: () async {
                            var box = Hive.box('authBox');
                            await box.clear();
                            Navigator.pushReplacementNamed(
                                context,
                                RouteNames.signInPage,);
                          },
                          child: Text('Ha'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
