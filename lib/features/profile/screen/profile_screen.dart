import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/core/router/app_router.dart';
import 'package:pravago/core/theme/bloc/theme_bloc.dart';
import 'package:pravago/core/utils/app_snackbar.dart';
import 'package:pravago/features/profile/bloc/profile_bloc.dart';
import 'package:pravago/features/profile/widgets/confirm_dialog.dart';
import 'package:pravago/features/profile/widgets/profile_list_tile.dart';
import 'package:pravago/features/profile/widgets/section_card.dart';
import 'package:pravago/features/profile/widgets/section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              AppSnackBar.showError(context, message: state.message);
            }

            if (state is ProfileUnauthenticated) {
              context.go(AppRouter.login);
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
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
              );
            }
            if (state is ProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                child: Padding(
                  padding: AppPadding.pH24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTextStrings.settings,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      AppSpacing.h20,
                      // Profile Card
                      SectionCard(
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50.r,
                                    backgroundColor: AppColors.blue100,
                                    backgroundImage:
                                    user.profileImage != null &&
                                        user.profileImage!.isNotEmpty
                                        ? NetworkImage(user.profileImage!)
                                        : null,
                                    child:
                                    user.profileImage == null ||
                                        user.profileImage!.isEmpty
                                        ? Icon(
                                      Iconsax.user,
                                      size: AppSize.loader40,
                                      color: AppColors.blue500,
                                    )
                                        : null,
                                  ),
                                  AppSpacing.h20,

                                  // User fullName
                                  Text(
                                    user.fullName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? AppColors.grey200
                                          : AppColors.grey800,
                                    ),
                                  ),

                                  AppSpacing.h8,

                                  // User email
                                  Text(
                                    user.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      color: isDark
                                          ? AppColors.grey200
                                          : AppColors.grey800,
                                    ),
                                  ),
                                  AppSpacing.h8,
                                  // User phone number
                                  Text(
                                    user.phoneNumber,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      color: isDark
                                          ? AppColors.grey200
                                          : AppColors.grey800,
                                    ),
                                  ),
                                  AppSpacing.h14,
                                  const Divider(),
                                  ProfileListTile(
                                    icon: Iconsax.user_edit,
                                    title: 'Profilni tahrirlash',
                                    onTap: () {},
                                  ),
                                  ProfileListTile(
                                    icon: Iconsax.security_safe,
                                    title: 'Xavfsizlik',
                                    subtitle: 'Tez kunda...',
                                    enabled: false,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.h20,
                      const SectionTitle(title: 'Ilova Sozlamalari'),
                      AppSpacing.h8,
                      SectionCard(
                        isInset: true,
                        child: Column(
                          children: [
                            SwitchListTile(
                              secondary: Icon(
                                isDark ? Iconsax.sun : Iconsax.moon,
                                color: AppColors.blue400,
                              ),
                              title: Text(
                                "Tungi rejim",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              value: isDark,
                              activeThumbColor: AppColors.blue500,
                              onChanged: (value) {
                                final newMode = value
                                    ? ThemeMode.dark
                                    : ThemeMode.light;
                                context.read<ThemeBloc>().add(
                                  ChangeThemeEvent(newMode),
                                );
                              },
                            ),
                            Divider(
                              color: isDark
                                  ? AppColors.blue900.withValues(alpha: 0.5)
                                  : AppColors.blue100,
                            ),
                            ProfileListTile(
                              icon: Iconsax.global,
                              title: 'Ilova tili',
                              trailingText: 'O\'zbekcha',
                              onTap: () {},
                            ),
                            Divider(
                              color: isDark
                                  ? AppColors.blue900.withValues(alpha: 0.5)
                                  : AppColors.blue100,
                            ),
                            ProfileListTile(
                              icon: Iconsax.notification,
                              title: 'Bildirishnomalar',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.h20,

                      // Help and Support
                      const SectionTitle(
                        title: 'Yordam va Huquqiy Ma\'lumotlar',
                      ),
                      AppSpacing.h8,
                      SectionCard(
                        isInset: true,
                        child: Column(
                          children: [
                            ProfileListTile(
                              icon: Iconsax.message_question,
                              title: 'Yordam va Qo\'llab-quvvatlash',
                              onTap: () {},
                            ),
                            Divider(
                              color: isDark
                                  ? AppColors.blue900.withValues(alpha: 0.5)
                                  : AppColors.blue100,
                            ),
                            ProfileListTile(
                              icon: Iconsax.document_text,
                              title:
                              'Maxfiylik siyosati va Foydalanish shartlari',
                              onTap: () {},
                            ),
                            Divider(
                              color: isDark
                                  ? AppColors.blue900.withValues(alpha: 0.5)
                                  : AppColors.blue100,
                            ),
                            ProfileListTile(
                              icon: Iconsax.info_circle,
                              title: 'Ilova haqida',
                              trailingText: "v1.0.0",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),

                      AppSpacing.h20,

                      // Account Settings
                      const SectionTitle(title: 'Hisob Sozlamalari'),
                      AppSpacing.h8,
                      SectionCard(
                        isInset: true,
                        child: Column(
                          children: [
                            ProfileListTile(
                              icon: Iconsax.logout,
                              title: 'Tizimdan chiqish',
                              onTap: () {
                                _showLogoutDialog(context);
                              },
                              textColor: AppColors.error,
                              iconColor: AppColors.error,
                            ),
                            Divider(
                              color: isDark
                                  ? AppColors.blue900.withValues(alpha: 0.5)
                                  : AppColors.blue100,
                            ),
                            ProfileListTile(
                              icon: Iconsax.trash,
                              title: 'Hisobni o\'chirish',
                              onTap: () {
                                _showDeleteAccountDialog(context);
                              },
                              textColor: AppColors.error,
                              iconColor: AppColors.error,
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.h14,
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(GetProfileEvent());
                },
                child: const Text('Get Profile'),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierColor: Colors.black54,
      builder: (dialogContext) => ConfirmDialog(
        icon: Icons.logout_rounded,
        accentColor: AppColors.error,
        title: 'Tizimdan chiqish',
        message: 'Haqiqatan ham hisobingizdan chiqmoqchimisiz?',
        cancelText: 'Bekor qilish',
        confirmText: 'Chiqish',
        onCancel: () => dialogContext.pop(),
        onConfirm: () {
          dialogContext.pop();
          parentContext.read<ProfileBloc>().add(LogoutEvent());
        },
      ),
    );
  }
  void _showDeleteAccountDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierColor: Colors.black54,
      builder: (dialogContext) => ConfirmDialog(
        icon: Icons.delete_forever_rounded,
        accentColor: AppColors.error,
        title: 'Hisobni o\'chirish',
        message: 'Hisobingiz butunlay o\'chiriladi.',
        warning: 'Bu amalni ortga qaytarib bo\'lmaydi!',
        cancelText: 'Bekor qilish',
        confirmText: 'O\'chirish',
        onCancel: () => dialogContext.pop(),
        onConfirm: () {
          dialogContext.pop();
          parentContext.read<ProfileBloc>().add(DeleteAccountEvent());
        },
      ),
    );
  }
}

