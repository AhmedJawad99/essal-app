import 'dart:math';

import 'package:essal_app/core/constants/app_colors.dart';
import 'package:essal_app/features/auth/data/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset(
                  'assets/logo/logo-white-bg.png',
                  height: 150,
                  width: 150,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Please enter your credentials',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                Gap(20),
                Row(
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ],
                ),
                Gap(5),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    //labelText: 'Email',
                    hintText: 'example@mail.com',
                    border: OutlineInputBorder(),
                  ),
                ),
                Gap(10),
                Row(
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ],
                ),
                Gap(5),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    //labelText: 'Password',
                    hintText: '**********',
                    border: const OutlineInputBorder(),

                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  obscureText: true,
                ),

                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text('Forget your password?')],
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            print(emailController.text);
                            print(passwordController.text);
                            await AuthRepo().login(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
