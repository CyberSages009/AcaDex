import 'package:flutter/material.dart';
import 'subject_page.dart';
import '../widgets/animated_tile.dart';

class SemesterPage extends StatelessWidget {
  final String year;
  final String role;
  final String userId;

  const SemesterPage({
    super.key,
    required this.year,
    required this.role,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final semesters = ['Odd Semester', 'Even Semester'];

    return Scaffold(
      appBar: AppBar(
        title: Text('$year • Semesters'),
        flexibleSpace: const _GradientBar(),
      ),
      body: ListView.builder(
        itemCount: semesters.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final semester = semesters[index];
          return AnimatedTile(
            title: semester,
            subtitle: 'Select $semester subjects',
            icon: Icons.school, // ✅ added
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, a, b) => SubjectPage(
                    year: year,
                    semester: semester,
                    role: role,
                    userId: userId,
                  ),
                  transitionsBuilder: (_, a, __, child) =>
                      FadeTransition(opacity: a, child: child),
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
