import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';

class AppSidebar extends StatelessWidget {
  final String currentRoute;
  
  const AppSidebar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    
    return Container(
      width: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.card,
            theme.colorScheme.background,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.border.withOpacity(0.5),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo/Brand with gradient
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  Colors.transparent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    LucideIcons.disc,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spin Track',
                      style: theme.textTheme.h4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Table Tennis Tracker',
                      style: theme.textTheme.small.copyWith(
                        color: theme.colorScheme.mutedForeground,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Navigation Items
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _NavItem(
                    icon: LucideIcons.layoutDashboard,
                    label: 'Dashboard',
                    isActive: currentRoute == '/dashboard',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                  ),
                  _NavItem(
                    icon: LucideIcons.plus,
                    label: 'Log New Entry',
                    isActive: currentRoute == '/log-entry',
                    onTap: () {
                      Navigator.pushNamed(context, '/log-entry');
                    },
                  ),
                  _NavItem(
                    icon: LucideIcons.history,
                    label: 'History',
                    isActive: currentRoute == '/sessions-list',
                    onTap: () {
                      Navigator.pushNamed(context, '/sessions-list');
                    },
                  ),
                  _NavItem(
                    icon: LucideIcons.mapPin,
                    label: 'Locations',
                    isActive: currentRoute == '/locations',
                    onTap: () {
                      // TODO: Navigate to locations
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'MORE',
                      style: theme.textTheme.small.copyWith(
                        color: theme.colorScheme.mutedForeground,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  
                  _NavItem(
                    icon: LucideIcons.user,
                    label: 'My Profile',
                    isActive: currentRoute == '/profile',
                    onTap: () {
                      // TODO: Navigate to profile
                    },
                  ),
                  _NavItem(
                    icon: LucideIcons.trophy,
                    label: 'Leaderboard',
                    isActive: currentRoute == '/leaderboard',
                    onTap: () {
                      // TODO: Navigate to leaderboard
                    },
                  ),
                  _NavItem(
                    icon: LucideIcons.activity,
                    label: 'Analytics',
                    isActive: currentRoute == '/analytics',
                    onTap: () {
                      // TODO: Navigate to analytics
                    },
                  ),
                  _NavItem(
                    icon: LucideIcons.info,
                    label: 'About',
                    isActive: currentRoute == '/about',
                    onTap: () {
                      // TODO: Navigate to about
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.15),
                        theme.colorScheme.primary.withOpacity(0.08),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
              border: isActive
                  ? Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: isActive
                      ? BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        )
                      : null,
                  child: Icon(
                    icon,
                    size: 18,
                    color: isActive 
                        ? theme.colorScheme.primary
                        : theme.colorScheme.mutedForeground,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.p.copyWith(
                      color: isActive 
                          ? theme.colorScheme.primary
                          : theme.colorScheme.foreground,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

