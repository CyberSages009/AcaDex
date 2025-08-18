import 'package:flutter/material.dart';
import 'semester_page.dart';
import '../widgets/animated_tile.dart';

class YearPage extends StatelessWidget {
  final String role;
  final String userId;

  const YearPage({
    super.key,
    required this.role,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final years = ['2nd Year', '3rd Year', '4th Year'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Year'),
        flexibleSpace: const _GradientBar(),
      ),
      body: ListView.builder(
        itemCount: years.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final year = years[index];
          return AnimatedTile(
            title: year,
            subtitle: 'Open semesters',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute( // ✅ FIXED
                  builder: (_) => SemesterPage(
                    year: year,
                    role: role,
                    userId: userId,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _GradientBar extends StatelessWidget {
  const _GradientBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF6750A4), Color(0xFF1180FF)]),
      ),
    );
  }
}
