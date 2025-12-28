import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/app_sidebar.dart';
import '../widgets/stats_cards.dart';
import '../widgets/badges_section.dart';
import '../widgets/performance_chart.dart';
import '../widgets/gear_performance_index.dart';
import '../widgets/recent_sessions.dart';
import '../../../equipment/presentation/widgets/equipment_status_card.dart';
import '../../../equipment/presentation/widgets/add_equipment_dialog.dart';
import '../../../equipment/domain/entities/equipment.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PaddleSetup? _currentPaddleSetup;

  @override
  void initState() {
    super.initState();
    // TODO: Load paddle setup from storage/database
  }

  void _showAddEquipmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AddEquipmentDialog(
        paddleSetup: _currentPaddleSetup,
        onSave: (paddleSetup) {
          setState(() {
            _currentPaddleSetup = paddleSetup;
          });
          // TODO: Save to storage/database
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      drawer: isMobile ? Drawer(child: const AppSidebar(currentRoute: '/dashboard')) : null,
      body: Row(
        children: [
          // Sidebar (hidden on mobile)
          if (!isMobile) const AppSidebar(currentRoute: '/dashboard'),

          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.card,
                    border: Border(bottom: BorderSide(color: theme.colorScheme.border, width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (isMobile)
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: IconButton(
                                icon: const Icon(LucideIcons.menu, size: 22),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ),
                          Text(
                            'Dashboard',
                            style: theme.textTheme.h2.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 20 : 24,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (!isMobile)
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
                          if (!isMobile) const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor: theme.colorScheme.primary,
                            radius: isMobile ? 16 : 18,
                            child: Text(
                              'V',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 12 : 14,
                              ),
                            ),
                          ),
                          if (!isMobile) ...[
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
                        ],
                      ),
                    ],
                  ),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isMobile ? 16 : 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats cards
                        const StatsCards(),
                        const SizedBox(height: 24),

                        // Badges in one row
                        const BadgesSection(),
                        const SizedBox(height: 24),

                        // Equipment Status and Performance Chart row (responsive)
                        if (isMobile || isTablet)
                          Column(
                            children: [
                              EquipmentStatusCard(
                                paddleSetup: _currentPaddleSetup,
                                onAddEquipment: _showAddEquipmentDialog,
                                onEditEquipment: _showAddEquipmentDialog,
                              ),
                              const SizedBox(height: 24),
                              const PerformanceChart(),
                            ],
                          )
                         else
                           SizedBox(
                             height: 380,
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.stretch,
                               children: [
                                 Expanded(
                                   flex: 1,
                                   child: EquipmentStatusCard(
                                     paddleSetup: _currentPaddleSetup,
                                     onAddEquipment: _showAddEquipmentDialog,
                                     onEditEquipment: _showAddEquipmentDialog,
                                   ),
                                 ),
                                 const SizedBox(width: 20),
                                 const Expanded(flex: 1, child: PerformanceChart()),
                               ],
                             ),
                           ),
                        const SizedBox(height: 24),

                        // GPI
                        const GearPerformanceIndex(),
                        const SizedBox(height: 24),

                        // Recent sessions
                        const RecentSessions(),

                        // Bottom padding for mobile
                        if (isMobile) const SizedBox(height: 40),
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
