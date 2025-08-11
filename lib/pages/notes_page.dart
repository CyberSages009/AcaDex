import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  final String subject;
  final String role;
  final String userId;

  const NotesPage({
    super.key,
    this.subject = "Unknown Subject",
    required this.role,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF512F), Color(0xFFF09819)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                subject,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 120,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
              if (role == "Teacher") ...[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // Upload notes logic
                  },
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: const Text(
                    "Upload Notes",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  // View/download notes logic
                },
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text(
                  "View / Download Notes",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
