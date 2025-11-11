import 'package:flutter/material.dart';
import '../widgets/greeting_section.dart';
import '../widgets/stats_cards.dart';
import '../widgets/badges_section.dart';
import '../widgets/performance_chart.dart';
import '../widgets/recent_sessions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Spin Track',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            // TODO: Open drawer/menu
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // TODO: Navigate to search
            },
          ),
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Colors.black87,
            ),
            onPressed: () {
              // TODO: Toggle theme
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh data
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              const GreetingSection(),

              const SizedBox(height: 24),

              // Lifetime Stats Cards
              const StatsCards(),

              const SizedBox(height: 24),

              // Badges Section
              const BadgesSection(),

              const SizedBox(height: 24),

              // Performance Trend Chart
              const PerformanceChart(),

              const SizedBox(height: 24),

              // Recent Sessions
              const RecentSessions(),

              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Log Entry
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Переход к логированию тренировки')),
          );
        },
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.add),
        label: const Text('Новая тренировка'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

