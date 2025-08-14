import 'package:flutter/material.dart';
import 'subjects_page.dart';
import 'animated_tile.dart';

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
      appBar: AppBar(title: Text('Select Semester - $year')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: semesters.length,
        itemBuilder: (context, index) {
          final sem = semesters[index];
          return AnimatedTile(
            index: index,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                title: Text(sem, style: const TextStyle(fontSize: 18)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    _buildPageRoute(
                      SubjectsPage(
                        year: year,
                        semester: sem,
                        role: role,
                        userId: userId,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.2, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
