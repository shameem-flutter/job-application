import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:job_application/constants/colors.dart';

class MobileDashboardScreen extends StatelessWidget {
  const MobileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Summary Cards Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              summaryCard("Total Job Postings", "12"),
              summaryCard("Total Applicants", "395"),
              summaryCard("Appointments", "18"),
              summaryCard("Total Applications", "892"),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Application Trends",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Number of applications received per month (sample data)",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),

          const SizedBox(height: 20),

          /// Chart Container
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: applicationTrendsChart(),
          ),
        ],
      ),
    );
  }

  Widget summaryCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget applicationTrendsChart() {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => secondaryColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()}',
                TextStyle(color: primaryColor),
              );
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
              FlLine(strokeWidth: 1, color: Color(0xFFE6E6E6)),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
            right: BorderSide(color: Colors.transparent, width: 0),
            top: BorderSide(color: Colors.transparent, width: 0),
          ),
        ),

        minY: 0,
        maxY: 320,

        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: 80,
              getTitlesWidget: (value, meta) {
                final v = value.toInt();
                if (v % 80 == 0 && v >= 0 && v <= 320) {
                  return Text("$v", style: const TextStyle(fontSize: 12));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text("Jan", style: TextStyle(fontSize: 12));
                  case 1:
                    return const Text("Feb", style: TextStyle(fontSize: 12));
                  case 2:
                    return const Text("Mar", style: TextStyle(fontSize: 12));
                  case 3:
                    return const Text("Apr", style: TextStyle(fontSize: 12));
                  case 4:
                    return const Text("May", style: TextStyle(fontSize: 12));
                  case 5:
                    return const Text("Jun", style: TextStyle(fontSize: 12));
                }
                return const Text("");
              },
            ),
          ),
        ),

        barGroups: [
          buildBar(0, 170),
          buildBar(1, 305),
          buildBar(2, 240),
          buildBar(3, 280),
          buildBar(4, 210),
          buildBar(5, 220),
        ],
      ),
    );
  }

  BarChartGroupData buildBar(int x, double height) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: height,
          width: 30,
          color: Colors.black.withValues(alpha: 0.85),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
      ],
    );
  }
}
