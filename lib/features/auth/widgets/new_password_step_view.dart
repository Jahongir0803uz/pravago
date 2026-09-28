import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/core/utils/validation.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';

class NewPasswordStepView extends StatefulWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const NewPasswordStepView({
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.formKey,
    super.key,
  });

  @override
  State<NewPasswordStepView> createState() => _NewPasswordStepViewState();
}

class _NewPasswordStepViewState extends State<NewPasswordStepView> {
  bool _isNewPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        padding: AppPadding.pB30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.h20,

            Text(
              AppTextStrings.createNewPassword,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            AppSpacing.h14,

            Text(
              AppTextStrings.newPasswordSubtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey400),
            ),

            AppSpacing.h30,

            // New password
            TextFormField(
              controller: widget.newPasswordController,
              obscureText: _isNewPasswordObscure,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              scrollPadding: AppPadding.pB100,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: AppTextStrings.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isNewPasswordObscure = !_isNewPasswordObscure;
                    });
                  },
                  icon: Icon(
                    _isNewPasswordObscure ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                ),
              ),
              validator: AppValidator.validatePassword,
            ),

            AppSpacing.h20,

            // Confirm password
            TextFormField(
              controller: widget.confirmPasswordController,
              obscureText: _isConfirmPasswordObscure,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              scrollPadding: AppPadding.pB100,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: AppTextStrings.confirmPassword,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                    });
                  },
                  icon: Icon(
                    _isConfirmPasswordObscure ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppTextStrings.reEnterPassword;
                }

                if (value != widget.newPasswordController.text) {
                  return AppTextStrings.passwordNotMatch;
                }

                return null;
              },
              onFieldSubmitted: (_) {
                _resetPassword();
              },
            ),

            AppSpacing.h30,

            // BUTTON
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final bool isLoading = state is AuthLoading;

                return SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.blue400, AppColors.blue600],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: AppRadius.r10,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: AppRadius.r10,
                        onTap: isLoading ? null : _resetPassword,
                        child: Center(
                          child: isLoading
                              ? SizedBox(
                                  width: AppSize.loader24,
                                  height: AppSize.loader24,
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
                                  AppTextStrings.resetPassword,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(color: AppColors.white),
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            AppSpacing.h30,
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    final bool isValid = widget.formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
      ResetPasswordRequested(widget.newPasswordController.text.trim()),
    );
  }
}
