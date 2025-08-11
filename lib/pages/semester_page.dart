import 'package:flutter/material.dart';
import 'subjects_page.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: semesters.length,
          itemBuilder: (context, index) {
            final sem = semesters[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubjectsPage(
                      year: year,
                      semester: sem,
                      role: role,
                      userId: userId,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  title: Text(
                    sem,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
