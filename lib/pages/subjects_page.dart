import 'package:flutter/material.dart';
import 'notes_page.dart';
import 'animated_tile.dart';

class SubjectsPage extends StatelessWidget {
  final String year;
  final String semester;
  final String role;
  final String userId;

  const SubjectsPage({
    super.key,
    required this.year,
    required this.semester,
    required this.role,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = _getSubjects(year, semester);

    return Scaffold(
      appBar: AppBar(title: Text('$semester - $year')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return AnimatedTile(
            index: index,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                title: Text(subject, style: const TextStyle(fontSize: 18)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    _buildPageRoute(
                      NotesPage(
                        year: year,
                        semester: semester,
                        subject: subject,
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

  List<String> _getSubjects(String year, String semester) {
    if (year == '2nd Year' && semester == 'Odd Semester') {
      return [
        'Digital Principles and Computer Organization',
        'Design Thinking',
        'Data Structure',
        'Object Oriented Programming',
        'Algebra and Number Theory',
      ];
    } else if (year == '2nd Year' && semester == 'Even Semester') {
      return [
        'Computer networks',
        'Probability and statistics',
        'Data base management system',
        'Design and analysis of algorithm',
        'Operating systems',
        'Universal human values and understanding harmony',
      ];
    } else if (year == '3rd Year' && semester == 'Odd Semester') {
      return [
        'Algebra and Number Theory',
        'Computer Networks',
        'Operating Systems',
        'Theory of Computation',
        'Embedded System',
      ];
    } else if (year == '3rd Year' && semester == 'Even Semester') {
      return [
        'Internet Programming',
        'Compiler Design',
        'Artificial Intelligence',
        'Cryptography and Network Security',
      ];
    } else if (year == '4th Year' && semester == 'Odd Semester') {
      return [
        'Distributed Systems and Cloud Computing',
        'Machine Learning',
        'Principles of Management',
      ];
    } else if (year == '4th Year' && semester == 'Even Semester') {
      return [
        'Professional Elective',
        'Project work',
      ];
    }
    return [];
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
