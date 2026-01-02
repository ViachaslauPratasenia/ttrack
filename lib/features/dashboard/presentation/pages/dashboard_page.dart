import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../../core/utils/dialog_utils.dart';
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
    DialogUtils.showAdaptiveDialog(
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
    final isMobile = screenWidth.isMobile;
    final isTablet = screenWidth.isTablet;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/log-entry');
        },
        backgroundColor: theme.colorScheme.primary,
        child: Icon(LucideIcons.plus, color: theme.colorScheme.primaryForeground),
      ),
      body: Column(
        children: [
          // Top bar
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.card,
              border: Border(bottom: BorderSide(color: theme.colorScheme.border, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        color: theme.colorScheme.primaryForeground,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.history, size: 20),
                      tooltip: 'History',
                      onPressed: () {
                        Navigator.pushNamed(context, '/sessions-list');
                      },
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.activity, size: 20),
                      tooltip: 'Analytics',
                      onPressed: () {
                        // TODO: Navigate to analytics
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(
                isMobile ? 16 : 24,
              ),
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
                      height: UIConstants.equipmentCardHeight,
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
                  if (isMobile) const SizedBox(height: 32 + 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
