import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/image_strings.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/core/router/app_router.dart';
import 'package:pravago/core/utils/app_snackbar.dart';
import 'package:pravago/core/utils/validation.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pravago/features/auth/presentation/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isRememberMe = false;
  bool _obscureText = true;

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    final isRemembered = prefs.getBool('is_remember_me') ?? false;

    if (isRemembered && savedEmail != null) {
      setState(() {
        _emailController.text = savedEmail;
        _isRememberMe = true;
      });
    }
  }
  @override
  void initState() {
    _loadSavedCredentials();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignInRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          isRememberMe: _isRememberMe,
        ),
      );
    }
  }

  void _showRegisterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rVT20),
      builder: (context) => const RegisterScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          AppSnackBar.showSuccess(
            context,
            message: AppTextStrings.signInSuccess,
          );
          context.go(AppRouter.main);
        } else if (state is AuthError) {
          AppSnackBar.showError(context, message: state.message);
        }
      },

      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppPadding.pH24,
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppSpacing.h30,
                        // logo
                        Image.asset(
                          AppImageStrings.appLogo,
                          height: AppSize.logoSize,
                          width: AppSize.logoSize,
                        ),
                        // Title
                        Text(
                          AppTextStrings.loginTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        AppSpacing.h14,
                        // Subtitle
                        Text(
                          AppTextStrings.loginSubTitle,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.grey400),
                        ),
                        AppSpacing.h24,
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
                            prefixIcon: Icon(
                              Iconsax.password_check,
                              size: 24.r,
                            ),
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
                        // Remember me
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _isRememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _isRememberMe = value!;
                                    });
                                  },
                                ),
                                AppSpacing.w10,
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isRememberMe = !_isRememberMe;
                                    });
                                  },
                                  child: Text(
                                    AppTextStrings.rememberMe,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => context.push(AppRouter.forgotPassword),
                              child: Text(
                                AppTextStrings.forgotPassword,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      color: isDark
                                          ? AppColors.grey200
                                          : AppColors.blue500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.h30,
                        // Login button
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
                            onPressed: isLoading
                                ? null
                                : () => _onLoginPressed(context),
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
                                    AppTextStrings.loginButton,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: AppColors.white),
                                  ),
                          ),
                        ),
                        AppSpacing.h30,
                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.grey400,
                                thickness: 1.r,
                                indent: 30.w,
                                endIndent: 20.w,
                              ),
                            ),
                            AppSpacing.w10,
                            Text(
                              AppTextStrings.or,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.grey400),
                            ),
                            AppSpacing.w10,
                            Expanded(
                              child: Divider(
                                color: AppColors.grey400,
                                thickness: 1.r,
                                indent: 20.w,
                                endIndent: 30.w,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.h30,
                        // Google buttons
                        InkWell(
                          onTap: () {},
                          borderRadius: AppRadius.r10,
                          highlightColor: AppColors.transparent,
                          splashColor: AppColors.transparent,
                          child: Container(
                            width: AppSize.loader60,
                            height: AppSize.loader60,
                            decoration: BoxDecoration(
                              color: AppColors.transparent,
                              borderRadius: AppRadius.r10,
                              border: Border.all(
                                color: AppColors.blue500,
                                width: 1.5.w,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                AppImageStrings.google,
                                width: AppSize.googleLogoSize,
                                height: AppSize.googleLogoSize,
                              ),
                            ),
                          ),
                        ),
                        AppSpacing.h30,
                        // Do not have account
                        GestureDetector(
                          onTap: () => _showRegisterBottomSheet(context),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.titleSmall,
                              children: [
                                const TextSpan(
                                  text: '${AppTextStrings.doNotHaveAccount}  ',
                                  style: TextStyle(color: AppColors.grey400),
                                ),
                                TextSpan(
                                  text: AppTextStrings.registerTitle,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(color: AppColors.blue500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppSpacing.h20,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
