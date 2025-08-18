import 'package:flutter/material.dart';
import 'notes_page.dart';
import '../widgets/animated_tile.dart';

class SubjectPage extends StatelessWidget {
  final String year;
  final String semester;
  final String role;
  final String userId;

  const SubjectPage({
    super.key,
    required this.year,
    required this.semester,
    required this.role,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final subjectsMap = {
      '2nd Year': {
        'Odd Semester': [
          'Digital Principles and Computer Organization',
          'Design Thinking',
          'Data Structure',
          'Object Oriented Programming',
          'Algebra and Number Theory',
        ],
        'Even Semester': [
          'Computer Networks',
          'Probability and Statistics',
          'Database Management System',
          'Design and Analysis of Algorithm',
          'Operating Systems',
          'Universal Human Values and Understanding Harmony',
        ],
      },
      '3rd Year': {
        'Odd Semester': [
          'Algebra and Number Theory',
          'Computer Networks',
          'Operating Systems',
          'Theory of Computation',
          'Embedded System',
        ],
        'Even Semester': [
          'Internet Programming',
          'Compiler Design',
          'Artificial Intelligence',
          'Cryptography and Network Security',
        ],
      },
      '4th Year': {
        'Odd Semester': [
          'Distributed Systems and Cloud Computing',
          'Machine Learning',
          'Principles of Management',
        ],
        'Even Semester': [
          'Professional Elective',
          'Project work',
        ],
      },
    };

    final subjects = subjectsMap[year]?[semester] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$semester • Subjects'),
        flexibleSpace: const _GradientBar(),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return AnimatedTile(
            title: subject,
            subtitle: 'Open notes',
            icon: Icons.book, // ✅ added
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, a, b) => NotesPage(
                    year: year,
                    semester: semester,
                    subject: subject,
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
