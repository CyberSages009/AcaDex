import 'package:flutter/material.dart';
import 'semester_page.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: years.length,
          itemBuilder: (context, index) {
            final year = years[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SemesterPage(
                      year: year,
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
                    colors: [Color(0xFFFFB75E), Color(0xFFED8F03)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  title: Text(
                    year,
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
