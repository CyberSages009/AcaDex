import 'package:flutter/material.dart';
import 'notes_page.dart';

class SubjectsPage extends StatelessWidget {
  final String year;
  final String semester;
  final String role;
  final String userId;

  SubjectsPage({
    super.key,
    required this.year,
    required this.semester,
    required this.role,
    required this.userId,
  });

  final Map<String, Map<String, List<String>>> subjectMap = {
    "2nd Year": {
      "Odd Semester": [
        "Digital Principles and Computer Organization",
        "Design Thinking",
        "Data Structure",
        "Object Oriented Programming",
        "Algebra and Number Theory"
      ],
      "Even Semester": [
        "Computer Networks",
        "Probability and Statistics",
        "Database Management System",
        "Design and Analysis of Algorithm",
        "Operating Systems",
        "Universal Human Values and Understanding Harmony"
      ]
    },
    "3rd Year": {
      "Odd Semester": [
        "Algebra and Number Theory",
        "Computer Networks",
        "Operating Systems",
        "Theory of Computation",
        "Embedded System"
      ],
      "Even Semester": [
        "Internet Programming",
        "Compiler Design",
        "Artificial Intelligence",
        "Cryptography and Network Security"
      ]
    },
    "4th Year": {
      "Odd Semester": [
        "Distributed Systems and Cloud Computing",
        "Machine Learning",
        "Principles of Management"
      ],
      "Even Semester": [
        "Professional Elective",
        "Project Work"
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    final subjects = subjectMap[year]?[semester] ?? [];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B09B), Color(0xFF96C93D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotesPage(
                      subject: subject,
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
                    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
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
                    subject,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
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
