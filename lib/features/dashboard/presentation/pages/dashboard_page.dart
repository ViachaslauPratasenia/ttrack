import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../widgets/greeting_section.dart';
import '../widgets/stats_cards.dart';
import '../widgets/badges_section.dart';
import '../widgets/performance_chart.dart';
import '../widgets/recent_sessions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Spin Track',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.menu),
          onPressed: () {
            // TODO: Open drawer/menu
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search),
            onPressed: () {
              // TODO: Navigate to search
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.sun),
            onPressed: () {
              // TODO: Toggle theme
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: const Text(
                'ВП',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh data
          await Future.delayed(const Duration(seconds: 1));
        },
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingSection(),
              SizedBox(height: 24),
              StatsCards(),
              SizedBox(height: 24),
              BadgesSection(),
              SizedBox(height: 24),
              PerformanceChart(),
              SizedBox(height: 24),
              RecentSessions(),
              SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: ShadButton(
        onPressed: () {
          Navigator.pushNamed(context, '/log-entry');
        },
        size: ShadButtonSize.lg,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.plus, size: 20),
            SizedBox(width: 8),
            Text('Новая тренировка'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
