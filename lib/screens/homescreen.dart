import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:job_application/constants/colors.dart';
import 'package:job_application/constants/gap_func.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Active Jobs',
                        value: '12',
                        icon: Icons.work_outline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: 'Total Applicants',
                        value: '248',
                        icon: Icons.people_outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: 'Upcoming Interviews',
                  value: '8',
                  icon: Icons.calendar_today_outlined,
                  fullWidth: true,
                ),

                const SizedBox(height: 24),

                // Recent Job Postings
                _SectionCard(
                  title: 'Recent Job Postings',
                  subtitle: 'An overview of your most recent job openings.',
                  child: Column(
                    children: [
                      _JobPostingItem(
                        title: 'Senior Flutter Developer',
                        company: 'Tech Corp',
                        applicants: 45,
                      ),
                      const Divider(height: 1),
                      _JobPostingItem(
                        title: 'UI/UX Designer',
                        company: 'Design Studio',
                        applicants: 32,
                      ),
                      const Divider(height: 1),
                      _JobPostingItem(
                        title: 'Product Manager',
                        company: 'Startup Inc',
                        applicants: 28,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Recent Applicants
                _SectionCard(
                  title: 'Recent Applicants',
                  subtitle: 'The latest candidates who applied to your jobs.',
                  child: Column(
                    children: [
                      _ApplicantItem(
                        name: 'John Doe',
                        position: 'Flutter Developer',
                        time: '2 hours ago',
                      ),
                      const Divider(height: 1),
                      _ApplicantItem(
                        name: 'Jane Smith',
                        position: 'UI/UX Designer',
                        time: '5 hours ago',
                      ),
                      const Divider(height: 1),
                      _ApplicantItem(
                        name: 'Mike Johnson',
                        position: 'Product Manager',
                        time: '1 day ago',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Application Trends Chart
                _SectionCard(
                  title: 'Application Trends (Sample)',
                  subtitle: '',
                  child: SizedBox(
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 16),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceEvenly,
                          maxY: 200,
                          minY: 0,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            drawHorizontalLine: true,
                            horizontalInterval: 50,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.grey.shade200,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            show: true,
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    'Jan',
                                    'Feb',
                                    'Mar',
                                    'Apr',
                                    'May',
                                    'Jun',
                                  ];
                                  if (value.toInt() >= 0 &&
                                      value.toInt() < months.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        months[value.toInt()],
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 44,
                                interval: 50,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBorderRadius: BorderRadius.circular(8),
                              tooltipMargin: 0,
                              tooltipPadding: const EdgeInsets.all(8),
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      '${rod.toY.toInt()}',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                            ),
                          ),
                          barGroups: [
                            makeGroup(0, 57),
                            makeGroup(1, 95),
                            makeGroup(2, 140),
                            makeGroup(3, 80),
                            makeGroup(4, 195),
                            makeGroup(5, 175),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                vertGap(80),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool fullWidth;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: Colors.grey.shade400, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _JobPostingItem extends StatelessWidget {
  final String title;
  final String company;
  final int applicants;

  const _JobPostingItem({
    required this.title,
    required this.company,
    required this.applicants,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.work_outline, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  company,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            '$applicants applicants',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ApplicantItem extends StatelessWidget {
  final String name;
  final String position;
  final String time;

  const _ApplicantItem({
    required this.name,
    required this.position,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade300,
            child: Text(
              name[0],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  position,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

BarChartGroupData makeGroup(int x, double value) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: value,
        gradient: LinearGradient(
          colors: [secondaryColor, Colors.indigo.shade400],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        width: 20,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          toY: 200,
          color: Colors.grey.shade100,
        ),
      ),
    ],
  );
}
