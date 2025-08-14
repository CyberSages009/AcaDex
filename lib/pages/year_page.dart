import 'package:flutter/material.dart';
import 'semester_page.dart';
import 'animated_tile.dart';

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
      appBar: AppBar(title: const Text('Select Year')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          return AnimatedTile(
            index: index,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                title: Text(year, style: const TextStyle(fontSize: 18)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    _buildPageRoute(
                      SemesterPage(
                        year: year,
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
