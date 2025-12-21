import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../widgets/app_sidebar.dart';
import '../widgets/stats_cards.dart';
import '../widgets/badges_section.dart';
import '../widgets/performance_chart.dart';
import '../widgets/gear_performance_index.dart';
import '../widgets/recent_sessions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Row(
        children: [
          // Sidebar
          const AppSidebar(currentRoute: '/dashboard'),
          
          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.card,
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.border,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dashboard',
                        style: theme.textTheme.h2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(LucideIcons.search, size: 20),
                            onPressed: () {
                              // TODO: Search
                            },
                          ),
                          IconButton(
                            icon: const Icon(LucideIcons.sun, size: 20),
                            onPressed: () {
                              // TODO: Toggle theme
                            },
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor: theme.colorScheme.primary,
                            radius: 18,
                            child: const Text(
                              'V',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Viachaslau',
                                style: theme.textTheme.small.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Logout',
                                style: theme.textTheme.small.copyWith(
                                  color: theme.colorScheme.mutedForeground,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats cards
                        const StatsCards(),
                        const SizedBox(height: 24),
                        
                        // Badges and Performance row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges section (left side)
                            const Expanded(
                              flex: 1,
                              child: BadgesSection(),
                            ),
                            const SizedBox(width: 24),
                            
                            // Performance chart (right side)
                            const Expanded(
                              flex: 1,
                              child: PerformanceChart(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // GPI
                        const GearPerformanceIndex(),
                        const SizedBox(height: 24),
                        
                        // Recent sessions
                        const RecentSessions(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
