import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class GenderDistributionDashboard extends StatelessWidget {
  const GenderDistributionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String?> gradeLevels = [null, '7', '8', '9', '10', '11', '12'];

    return Scaffold(
      backgroundColor: const Color(0xFF001b13),
      appBar: AppBar(
        title: const Text("Gender Distribution by Grade Level"),
        backgroundColor: const Color(0xFF002f24),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: gradeLevels
              .map((level) => DistributionGender(gradeLevel: level))
              .toList(),
        ),
      ),
    );
  }
}

class DistributionGender extends StatefulWidget {
  final String? gradeLevel; // null = all grades

  const DistributionGender({super.key, this.gradeLevel});

  @override
  State<DistributionGender> createState() => _DistributionGenderState();
}

class _DistributionGenderState extends State<DistributionGender> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, int>>(
      stream: getGenderDistribution(widget.gradeLevel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text("Error loading data"));
        }

        final genderData = snapshot.data!;
        final maleCount = genderData['Male'] ?? 0;
        final femaleCount = genderData['Female'] ?? 0;
        final total = maleCount + femaleCount;

        final dataList = [
          _BarData(Colors.blue, maleCount.toDouble()),
          _BarData(Colors.pink, femaleCount.toDouble()),
        ];

        return Container(
          width: MediaQuery.of(context).size.width / 3.3,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 75),
          decoration: BoxDecoration(
            color: const Color(0xFF002f24),
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 80),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.gradeLevel == null
                      ? "Overall Gender Distribution"
                      : "Grade ${widget.gradeLevel} Gender Distribution",
                  style: TextStyle(
                    fontFamily: "SB",
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 60,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.face, color: Colors.blue),
                      SizedBox(width: MediaQuery.of(context).size.width / 300),
                      Text(
                        "Male: $maleCount",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.face, color: Colors.pink),
                      SizedBox(width: MediaQuery.of(context).size.width / 300),
                      Text(
                        "Female: $femaleCount",
                        style: const TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 60),
              Center(
                child: Text(
                  "Total: $total",
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: "SB",
                    fontSize: MediaQuery.of(context).size.width / 70,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 60),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4.8,
                  height: MediaQuery.of(context).size.width / 4.8,
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(
                        show: true,
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize:
                                MediaQuery.of(context).size.width / 50,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: _IconWidget(
                                  color: dataList[index].color,
                                  isSelected: false,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(),
                        topTitles: const AxisTitles(),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.withOpacity(0.4),
                          strokeWidth: 1,
                        ),
                      ),
                      barGroups: dataList.asMap().entries.map((e) {
                        final index = e.key;
                        final data = e.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data.value,
                              color: data.color,
                              width:
                                  MediaQuery.of(context).size.width / 30,
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ✅ Firestore Stream — supports All or per-grade filtering
  Stream<Map<String, int>> getGenderDistribution(String? gradeLevel) {
    Query usersQuery = FirebaseFirestore.instance
        .collection('users')
        .where('accountType', isEqualTo: 'student')
        .where('enrollment_status', whereIn: ['approved', 're-enrolled'])
        .where('Status', isEqualTo: 'active');

    if (gradeLevel != null) {
      usersQuery = usersQuery.where('grade_level', isEqualTo: gradeLevel);
    }

    return usersQuery.snapshots().map((snapshot) {
      final maleCount =
          snapshot.docs.where((doc) => doc['gender'] == 'Male').length;
      final femaleCount =
          snapshot.docs.where((doc) => doc['gender'] == 'Female').length;
      return {'Male': maleCount, 'Female': femaleCount};
    });
  }
}

/// Simple class for the bar chart data
class _BarData {
  const _BarData(this.color, this.value);
  final Color color;
  final double value;
}

/// Animated face icons for chart labels
class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.face,
      color: widget.color,
      size: MediaQuery.of(context).size.width / 53,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(begin: value as double, end: 0.0),
    ) as Tween<double>?;
  }
}
