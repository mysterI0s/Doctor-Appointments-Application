import 'package:final_project/core/constants/app_consts.dart';
import 'package:final_project/core/constants/app_images.dart';
import 'package:final_project/core/generic_widgets/custom_text_form_field/bloc/text_form_field_cubit.dart';
import 'package:final_project/core/generic_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:final_project/core/generic_widgets/main_button.dart';
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/app_text_style.dart';
import 'package:final_project/features/authentication/cubit/auth_cubit.dart';
import 'package:final_project/features/authentication/cubit/auth_state.dart';
import 'package:final_project/features/authentication/screens/sign_in_screen.dart';
import 'package:final_project/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TextFormFieldCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.f40W700NearBlackColor,
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: AppTextStyle.f12W400NearBlackColor.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                CustomTextFormField(
                  controller: nameController,
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: AppTextStyle.f12W400NearBlackColor.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                CustomTextFormField(
                  controller: emailAddressController,
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: AppTextStyle.f12W400NearBlackColor.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                CustomTextFormField(
                  isPassword: true,
                  controller: passwordController,
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm Password",
                    style: AppTextStyle.f12W400NearBlackColor.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                CustomTextFormField(
                  isConfirmPassword: true,
                  controller: confirmPasswordController,
                ),
                SizedBox(height: 40.h),
                BlocConsumer<AuthCubit, AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    if (state is RegisterLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return MainButton(
                          text: "Sign Up",
                          onPressed: () {
                            if (emailAddressController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                confirmPasswordController.text.isNotEmpty) {
                              context.read<AuthCubit>().register(
                                    emailAddressController.text,
                                    nameController.text,
                                    passwordController.text,
                                    confirmPasswordController.text,
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please fill all fields"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          });
                    }
                  },
                  listener: (BuildContext context, AuthState state) {
                    if (state is RegisterSuccessState) {
                      box.write('isLoggedIn', true);
                      box.write('user', state.model.user?.toJson());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Signed up Successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      });
                    }

                    if (state is RegisterErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMsg)));
                    }
                  },
                ),
                SizedBox(height: 32.h),
                Column(
                  children: [
                    Text(
                      "Or",
                      style: AppTextStyle.f32W700NearBlackColor.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 21.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            AppImages.facebook,
                            height: 32.r,
                            width: 32.r,
                          ),
                          onPressed: () {
                            // Facebook login
                          },
                        ),
                        SizedBox(width: 18.w),
                        IconButton(
                          icon: SvgPicture.asset(
                            AppImages.chrome,
                            height: 32.r,
                            width: 32.r,
                          ),
                          onPressed: () {
                            // Google login
                          },
                        ),
                        SizedBox(width: 18.w),
                        IconButton(
                          icon: SvgPicture.asset(
                            AppImages.x,
                            height: 32.r,
                            width: 32.r,
                          ),
                          onPressed: () {
                            // X login
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have An Account? ",
                      style: AppTextStyle.f12W400NearBlackColor.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Log In",
                        style: AppTextStyle.f12W400NearBlackColor.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
