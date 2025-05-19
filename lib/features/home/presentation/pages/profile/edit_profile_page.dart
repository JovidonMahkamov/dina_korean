import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../auth/presentation/widgets/text_field_widget.dart';
import '../../../domain/entities/profile.dart';
import '../../bloc/edit_profile/edit_profile_bloc.dart';
import '../../bloc/edit_profile/etid_profile_state.dart';
import '../../bloc/home_event.dart';
import '../../bloc/profile/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController userNameController;
  late TextEditingController phoneController;
  late TextEditingController telegramController;

  @override
  void initState() {
    super.initState();
    final profile = widget.profile;
    nameController = TextEditingController(text: profile.firstName);
    lastNameController = TextEditingController(text: profile.lastName);
    userNameController = TextEditingController(text: profile.login);
    phoneController = TextEditingController(text: profile.phone);
    telegramController = TextEditingController(text: profile.telegramId);
    context.read<ProfileBloc>().add(ProfileEvent());
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    telegramController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final updatedProfile = widget.profile.copyWith(
      firstName: nameController.text,
      lastName: lastNameController.text,
      login: userNameController.text,
      phone: phoneController.text,
      telegramId: telegramController.text,
    );

    context.read<EditProfileBloc>().add(EditProfilEvent(updatedProfile));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("O'zgartirishlar muvaffaqiyatli saqlandi")),
          );
          Navigator.pop(context,state.updatedProfile);
        } else if (state is EditProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Xatolik: ${state.message}')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context,RouteNames.bottomNavBar);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<EditProfileBloc, EditProfileState>(
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return Center(
                    child: SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader,
                        colors: [Colors.blueAccent],
                        strokeWidth: 2.w,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name'),
                      SizedBox(height: 10.h),
                      TextFieldWidget(
                        text: 'Name...',
                        textEditingController: nameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20.h),
                      Text('Last Name'),
                      SizedBox(height: 10.h),
                      TextFieldWidget(
                        text: 'Last Name...',
                        textEditingController: lastNameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20.h),
                      Text('User Name'),
                      SizedBox(height: 10.h),
                      TextFieldWidget(
                        text: 'User Name...',
                        textEditingController: userNameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20.h),
                      Text('Phone Number'),
                      SizedBox(height: 10.h),
                      TextFieldWidget(
                        text: 'Phone Number...',
                        textEditingController: phoneController,
                        obscureText: false,
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(height: 20.h),
                      Text('Telegram ID'),
                      SizedBox(height: 10.h),
                      TextFieldWidget(
                        text: 'Telegram ID...',
                        textEditingController: telegramController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 150.w,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Bekor qilish'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          SizedBox(
                            height: 60.h,
                            width: 150.w,
                            child: ElevatedButton(
                              onPressed: _saveProfile,
                              child: Text('Saqlash'),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
