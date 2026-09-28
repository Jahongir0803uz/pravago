import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pinput/pinput.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';

class OtpStepView extends StatelessWidget {
  final TextEditingController otpController;
  final String email;

  const OtpStepView({
    required this.otpController,
    required this.email,
    super.key,
  });

  void _verifyOtp(BuildContext context) {
    final String otp = otpController.text.trim();

    if (otp.length != 6) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(VerifyOTPRequested(email: email, token: otp));
  }

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 56.h,
      textStyle: Theme.of(
        context,
      ).textTheme.headlineMedium?.copyWith(color: AppColors.blue500),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: AppRadius.r10,
        border: Border.all(color: AppColors.grey300),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.blue500, width: 2.w),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.error, width: 1.5.w),
      ),
    );

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const ClampingScrollPhysics(),
      padding: AppPadding.pB30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.h20,

          Text(
            AppTextStrings.enterOtpCode,
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          AppSpacing.h14,

          Text(
            AppTextStrings.enterOtpCodeSubtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.grey400),
          ),

          AppSpacing.h30,

          Center(
            child: Pinput(
              length: 6,
              controller: otpController,

              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              errorPinTheme: errorPinTheme,

              showCursor: true,

              separatorBuilder: (index) {
                return AppSpacing.w6;
              },

              keyboardType: TextInputType.number,

              textInputAction: TextInputAction.done,

              scrollPadding: AppPadding.pB100,

              onCompleted: (pin) {
                FocusScope.of(context).unfocus();
              },
            ),
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
                      onTap: isLoading ? null : () => _verifyOtp(context),
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
                                AppTextStrings.submit,
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
    );
  }
}
