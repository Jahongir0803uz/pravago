import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/core/utils/app_snackbar.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pravago/features/auth/widgets/email_step_view.dart';
import 'package:pravago/features/auth/widgets/new_password_step_view.dart';
import 'package:pravago/features/auth/widgets/otp_step_view.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final PageController _pageController = PageController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _otpController =
  TextEditingController();

  final TextEditingController _newPasswordController =
  TextEditingController();

  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final GlobalKey<FormState> _emailFormKey =
  GlobalKey<FormState>();

  final GlobalKey<FormState> _newPasswordFormKey =
  GlobalKey<FormState>();

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage >= 2) return;

    FocusScope.of(context).unfocus();

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    if (_currentPage <= 0) return;

    FocusScope.of(context).unfocus();

    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleBack() {
    FocusScope.of(context).unfocus();

    if (_currentPage == 0) {
      context.pop();
      return;
    }

    _previousPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetCodeSentSuccess) {
          _nextPage();
        } else if (state is OtpVerifiedSuccess) {
          _nextPage();
        } else if (state is PasswordResetSuccess) {
          if (!context.mounted) return;

          context.pop();

          AppSnackBar.showSuccess(
            context,
            message: AppTextStrings.newPasswordUpdate,
          );
        } else if (state is AuthError) {
          if (!context.mounted) return;

          AppSnackBar.showError(
            context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;

        return Scaffold(
          resizeToAvoidBottomInset: false,

          backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,

          body: SafeArea(
            child: Padding(
              padding: AppPadding.pL24R24T24B(context),
              child: Column(
                children: [
                  // =========================
                  // HEADER
                  // =========================
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: isLoading
                              ? null
                              : _handleBack,
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Align(
                              alignment:
                              Alignment.centerLeft,
                              child: Icon(
                                Iconsax.arrow_left_2,
                                size: 24,
                                color: Theme.of(context)
                                    .iconTheme
                                    .color,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        Text(
                          '${_currentPage + 1}/3',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  // Header va content orasida joy
                  AppSpacing.h14,

                  // =========================
                  // PAGE VIEW
                  // =========================
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        if (!mounted) return;

                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        EmailStepView(
                          emailController:
                          _emailController,
                          formKey: _emailFormKey,
                        ),

                        OtpStepView(
                          otpController: _otpController,
                          email:
                          _emailController.text.trim(),
                        ),

                        NewPasswordStepView(
                          newPasswordController:
                          _newPasswordController,
                          confirmPasswordController:
                          _confirmPasswordController,
                          formKey:
                          _newPasswordFormKey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}