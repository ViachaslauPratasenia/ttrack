import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
        color: theme.colorScheme.card,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.border,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo/Brand
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    LucideIcons.disc,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Spin Track',
                  style: theme.textTheme.h4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isActive 
                  ? theme.colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive 
                      ? theme.colorScheme.primary
                      : theme.colorScheme.mutedForeground,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: theme.textTheme.p.copyWith(
                    color: isActive 
                        ? theme.colorScheme.primary
                        : theme.colorScheme.foreground,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
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

