import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/core/utils/app_snackbar.dart';
import 'package:pravago/core/utils/validation.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _obscureText = true;
  File? _imageFile;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Rasm tanlashda xatolik: $e');
    }
  }

  void _onRegisterPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final cleanPhone = _phoneNumberController.text.replaceAll(RegExp(r'\D'), '');

      context.read<AuthBloc>().add(
        SignUpRequested(
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phoneNumber: '+998$cleanPhone',
          imageFile: _imageFile,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          if (context.mounted) {
            context.pop();
            AppSnackBar.showSuccess(
              context,
              message: AppTextStrings.signUpSuccess,
            );
          }
        } else if (state is AuthError) {
          if (context.mounted) {
            AppSnackBar.showError(context, message: state.message);
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Padding(
          padding: AppPadding.pL24R24T24B(context),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Title
                  Text(
                    AppTextStrings.registerTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  AppSpacing.h14,

                  // Subtitle
                  Text(
                    AppTextStrings.registerSubTitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.grey400),
                  ),

                  AppSpacing.h20,

                  // Image
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 45.r,
                          backgroundColor: AppColors.grey200,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : null,
                          child: _imageFile == null
                              ? Icon(
                            Iconsax.user,
                            size: 24.r,
                            color: AppColors.blue500,
                          )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: AppPadding.pA8,
                            decoration: const BoxDecoration(
                              color: AppColors.blue500,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Iconsax.camera,
                              size: 16.r,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.h20,

                  // Full name
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      hintText: AppTextStrings.fullName,
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: Icon(Iconsax.user, size: 24.r),
                    ),
                    validator: AppValidator.validateFullName,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),

                  AppSpacing.h20,

                  // Phone Number
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.call, size: 24.r),
                      hintText: AppTextStrings.phoneNumber,
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixText: '+998 ',
                      prefixStyle: TextStyle(
                        fontSize: AppFontSize.fs14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    validator: AppValidator.validatePhoneNumber,
                  ),

                  AppSpacing.h20,

                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppTextStrings.email,
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: Icon(Iconsax.sms, size: 24.r),
                    ),
                    validator: AppValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpacing.h20,

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppTextStrings.password,
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: Icon(Iconsax.password_check, size: 24.r),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                          size: 24.r,
                        ),
                      ),
                    ),
                    validator: AppValidator.validatePassword,
                    obscureText: _obscureText,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  AppSpacing.h30,

                  // Register button
                  Ink(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.blue400, AppColors.blue600],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: AppRadius.r10,
                    ),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _onRegisterPressed(context),
                      child: isLoading
                          ? SizedBox(
                        height: AppSize.loader24,
                        width: AppSize.loader24,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballRotateChase,
                          colors: const [
                            AppColors.blue100,
                            AppColors.blue300,
                            AppColors.blue500,
                            AppColors.blue700,
                          ],
                          strokeWidth: 2.w,
                        ),
                      )
                          : Text(
                        AppTextStrings.registerButton,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                  AppSpacing.h30,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}