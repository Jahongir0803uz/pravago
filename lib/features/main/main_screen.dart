import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/features/home/screen/home_screen.dart';
import 'package:pravago/features/profile/screen/profile_screen.dart';
import 'package:pravago/features/profile/widgets/section_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(), // 0 - Home
    Center(child: Text('Coming soon...')), // 1 - Search / Explore
    Center(child: Text('Coming soon...')), // 2 - Saved / Favorites
    ProfileScreen(),
  ];

  final List<_NavItemData> _navItems = const [
    _NavItemData(icon: Iconsax.home, label: 'Bosh sahifa'),
    _NavItemData(icon: Iconsax.teacher, label: 'O\'rganish'),
    _NavItemData(icon: Iconsax.archive_book, label: 'Saqlanganlar'),
    _NavItemData(icon: Iconsax.setting, label: 'Sozlamalar'),
  ];

  void _onNavTapped(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark, // Android uchun
        statusBarBrightness:
        isDark ? Brightness.dark : Brightness.light, // iOS uchun
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: _FloatingBottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          onTap: _onNavTapped,
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}

class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavItemData> items;
  final ValueChanged<int> onTap;

  const _FloatingBottomNav({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: AppPadding.pL16R16T0B12,
        child: SectionCard(
          margin: EdgeInsets.zero,
          padding: AppPadding.pH6,
          borderRadius: 20,
          child: SizedBox(
            height: AppSize.loader60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(items.length, (index) {
                return Expanded(
                  child: _NavItem(
                    data: items[index],
                    selected: index == currentIndex,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onTap(index);
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final _NavItemData data;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icon = SizedBox(
      width: AppSize.loader44,
      height: AppSize.loader40,
      child: Icon(
        data.icon,
        size: 24,
        color: selected ? AppColors.blue500 : AppColors.grey400,
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeOut,
          child: selected
              ? SectionCard(
            key: const ValueKey('selected'),
            isInset: true,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            borderRadius: 14,
            child: icon,
          )
              : KeyedSubtree(key: const ValueKey('idle'), child: icon),
        ),
      ),
    );
  }
}