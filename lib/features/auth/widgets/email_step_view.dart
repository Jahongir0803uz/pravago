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

class EmailStepView extends StatelessWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  const EmailStepView({
    required this.emailController,
    required this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        padding: AppPadding.pB30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.h20,

            Text(
              AppTextStrings.resetPassword,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            AppSpacing.h14,

            Text(
              AppTextStrings.resetPasswordSubtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey400),
            ),

            AppSpacing.h30,

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              scrollPadding: AppPadding.pB100,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                labelText: AppTextStrings.email,

                labelStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.grey400),

                floatingLabelStyle: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.white
                          : AppColors.blue950,
                    ),

                prefixIcon: Icon(
                  Iconsax.sms,
                  color: Theme.of(context).iconTheme.color,
                ),

                contentPadding: AppPadding.pA14,
              ),
              validator: AppValidator.validateEmail,
            ),

            AppSpacing.h30,

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
                        onTap: isLoading
                            ? null
                            : () {
                                final bool isValid =
                                    formKey.currentState?.validate() ?? false;

                                if (!isValid) {
                                  return;
                                }

                                FocusScope.of(context).unfocus();

                                context.read<AuthBloc>().add(
                                  SendResetCodeRequested(
                                    emailController.text.trim(),
                                  ),
                                );
                              },
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
                                  AppTextStrings.sendCode,
                                  style: Theme.of(context).textTheme.titleLarge
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
}
