import 'package:essal_app/core/constants/app_colors.dart';
import 'package:essal_app/core/network/api_error.dart';
import 'package:essal_app/features/auth/data/models/user_model.dart';
import 'package:essal_app/features/auth/data/repos/auth_repo.dart';
import 'package:essal_app/shared/essal_button.dart';
import 'package:essal_app/shared/essal_text.dart';
import 'package:essal_app/shared/essal_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Login controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Register common controllers
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final regionIdController = TextEditingController();

  // Merchant specific controllers
  final storeNameController = TextEditingController();
  final storeAddressController = TextEditingController();
  final gpsLinkController = TextEditingController();

  // Driver specific controllers
  final vehicleTypeController = TextEditingController();
  final plateNumberController = TextEditingController();

  // State flags
  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _isRegisterPasswordHidden = true;
  bool _isRegisterConfirmPasswordHidden = true;
  bool _isRegisterMode = false;
  String selectedRole = 'driver'; // 'driver' or 'merchant'

  Future<UserModel?> login() async {
    if (!_isLoading) {
      if (loginFormKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        try {
          final response = await AuthRepo().login(
            emailController.text,
            passwordController.text,
          );

          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }

          if (response != null) {
            debugPrint(
              'Login success! Token: ${response.token}, User: ${response.name}',
            );
          }
        } catch (e) {
          if (mounted) {
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
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    regionIdController.dispose();

    storeNameController.dispose();
    storeAddressController.dispose();
    gpsLinkController.dispose();

    vehicleTypeController.dispose();
    plateNumberController.dispose();
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
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: _isRegisterMode
                    ? _buildRegisterForm()
                    : _buildLoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: loginFormKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo-white-bg.png',
              height: 150,
              width: 150,
            ),
            const EssalText(
              text: 'Welcome Back',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const EssalText(
              text: 'Please enter your credentials',
              color: AppColors.textSecondary,
            ),
            const Gap(20),
            const Row(
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
            const Row(
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
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              obscureText: _isPasswordHidden,
            ),
            const Gap(20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EssalText(text: 'Forget your password?', fontSize: 14),
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
            const Row(
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
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: EssalButton(
                    isLoading: _isLoading,
                    onPressed: () {
                      setState(() {
                        _isRegisterMode = true;
                      });
                    },
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
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: registerFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/logo-white-bg.png',
                    height: 110,
                    width: 110,
                  ),
                  const Gap(10),
                  const EssalText(
                    text: 'Create Account',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(4),
                  const EssalText(
                    text: 'Choose account type and enter your details',
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            const Gap(20),

            // Role Selection Tabs (Driver / Merchant)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRole = 'driver';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedRole == 'driver'
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: 18,
                                color: selectedRole == 'driver'
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                              const Gap(8),
                              Text(
                                'Driver',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedRole == 'driver'
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRole = 'merchant';
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedRole == 'merchant'
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.storefront,
                                size: 18,
                                color: selectedRole == 'merchant'
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                              const Gap(8),
                              Text(
                                'Merchant',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedRole == 'merchant'
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),

            // Name Field
            const EssalText(
              text: 'Full Name',
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            const Gap(5),
            EssalTextFormField(
              controller: registerNameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              hintText: 'John Doe',
              prefixIcon: Icon(Icons.person_outline),
            ),
            const Gap(15),

            // Email Field
            const EssalText(
              text: 'Email',
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            const Gap(5),
            TextFormField(
              controller: registerEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'example@mail.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const Gap(15),

            // Phone Field
            const EssalText(
              text: 'Phone Number',
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            const Gap(5),
            TextFormField(
              controller: registerPhoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: '+964 7XX XXX XXXX',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const Gap(15),

            // Password Field
            const EssalText(
              text: 'Password',
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            const Gap(5),
            TextFormField(
              controller: registerPasswordController,
              obscureText: _isRegisterPasswordHidden,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '**********',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isRegisterPasswordHidden = !_isRegisterPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _isRegisterPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
            const Gap(15),

            // Password Confirmation Field
            const EssalText(
              text: 'Confirm Password',
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            const Gap(5),
            TextFormField(
              controller: registerConfirmPasswordController,
              obscureText: _isRegisterConfirmPasswordHidden,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm password';
                } else if (value != registerPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '**********',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isRegisterConfirmPasswordHidden =
                          !_isRegisterConfirmPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _isRegisterConfirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
            const Gap(15),

            // Region ID Field (for all)
            const EssalText(
              text: 'Region ID',
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            const Gap(5),
            TextFormField(
              controller: regionIdController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter region ID';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: '1',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            const Gap(15),

            // Role specific fields
            if (selectedRole == 'merchant') ...[
              // Store Name
              const EssalText(
                text: 'Store Name',
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              const Gap(5),
              TextFormField(
                controller: storeNameController,
                validator: (value) {
                  if (selectedRole == 'merchant' &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter store name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'My Store Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.store_outlined),
                ),
              ),
              const Gap(15),

              // Store Address
              const EssalText(
                text: 'Store Address',
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              const Gap(5),
              TextFormField(
                controller: storeAddressController,
                validator: (value) {
                  if (selectedRole == 'merchant' &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter store address';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Baghdad, Street 14',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map_outlined),
                ),
              ),
              const Gap(15),

              // GPS Link
              const EssalText(
                text: 'GPS Link',
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              const Gap(5),
              TextFormField(
                controller: gpsLinkController,
                validator: (value) {
                  if (selectedRole == 'merchant' &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter GPS link';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'https://maps.google.com/?q=...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link_outlined),
                ),
              ),
              const Gap(15),
            ] else if (selectedRole == 'driver') ...[
              // Vehicle Type
              const EssalText(
                text: 'Vehicle Type',
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              const Gap(5),
              TextFormField(
                controller: vehicleTypeController,
                validator: (value) {
                  if (selectedRole == 'driver' &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter vehicle type';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Car / Motorcycle / Truck',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car_outlined),
                ),
              ),
              const Gap(15),

              // Plate Number
              const EssalText(
                text: 'Plate Number',
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              const Gap(5),
              TextFormField(
                controller: plateNumberController,
                validator: (value) {
                  if (selectedRole == 'driver' &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter plate number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: '12345 Baghdad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
              ),
              const Gap(15),
            ],

            const Gap(10),

            // Register Submit Button
            Row(
              children: [
                Expanded(
                  child: EssalButton(
                    isLoading: _isLoading,
                    onPressed: () {
                      if (registerFormKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Form valid! Role: $selectedRole, Name: ${registerNameController.text}',
                            ),
                          ),
                        );
                      }
                    },
                    text: 'Register',
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const Gap(15),

            // Back to Login switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EssalText(
                  text: 'Already have an account? ',
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRegisterMode = false;
                    });
                  },
                  child: const EssalText(
                    text: 'Login',
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
