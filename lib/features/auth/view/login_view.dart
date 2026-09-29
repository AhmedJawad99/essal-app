import 'package:essal_app/core/constants/app_colors.dart';
import 'package:essal_app/core/network/api_error.dart';
import 'package:essal_app/features/auth/data/models/user_model.dart';
import 'package:essal_app/features/auth/data/repos/auth_repo.dart';
import 'package:essal_app/shared/essal_button.dart';
import 'package:essal_app/shared/essal_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _isRegisterMode = false;

  Future<UserModel?> login() async {
    if (!_isLoading) {
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        try {
          final response = await AuthRepo().login(
            emailController.text,
            passwordController.text,
          );

          if (mounted)
            setState(() {
              _isLoading = false;
            });

          if (response != null) {
            print('✅ Login success!');
            print('Token: ${response.token}');
            print('User Name: ${response.name}');
          }
        } catch (e) {
          if (mounted)
            setState(() {
              _isLoading = false;
            });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e is ApiError ? e.message : 'Unhandled login error',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      }
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: formKey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/logo-white-bg.png',
                        height: 150,
                        width: 150,
                      ),
                      EssalText(
                        text: 'Welcome Back',
                        // color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      EssalText(
                        text: 'Please enter your credentials',
                        color: AppColors.textSecondary,
                        //fontSize: 16,
                        //fontWeight: FontWeight.normal,
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          EssalText(
                            text: 'Email',
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(5),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'example@mail.com',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          EssalText(
                            text: 'Password',
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(5),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '**********',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // تفعيل زر إخفاء وإظهار كلمة المرور
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: _isPasswordHidden,
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          EssalText(
                            text: 'Forget your password?',
                            //color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: EssalButton(
                              isLoading: _isLoading,
                              onPressed: login,
                              text: 'Login',
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: Divider(thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'OR',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                          const Expanded(child: Divider(thickness: 1)),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: EssalButton(
                              isLoading: _isLoading,
                              onPressed: () {},
                              text: 'Create Account',
                              color: Colors.white,
                              textColor: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
