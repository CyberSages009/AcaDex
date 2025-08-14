import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'animated_tile.dart';

class NotesPage extends StatefulWidget {
  final String year;
  final String semester;
  final String subject;
  final String role;
  final String userId;

  const NotesPage({
    super.key,
    required this.year,
    required this.semester,
    required this.subject,
    required this.role,
    required this.userId,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<File> uploadedFiles = [];

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'pptx', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        uploadedFiles.add(File(result.files.single.path!));
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File uploaded successfully")),
      );
    }
  }

  void _deleteFile(int index) {
    setState(() {
      uploadedFiles.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("File deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.isNotEmpty ? widget.subject : "Notes"),
      ),
      floatingActionButton: widget.role == "Teacher"
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload"),
              onPressed: _pickFile,
            )
          : null,
      body: uploadedFiles.isEmpty
          ? const Center(
              child: Text(
                "No files uploaded yet",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: uploadedFiles.length,
              itemBuilder: (context, index) {
                final file = uploadedFiles[index];
                return AnimatedTile(
                  index: index,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.insert_drive_file, color: Colors.blueAccent),
                      title: Text(
                        file.path.split('/').last,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      trailing: widget.role == "Teacher"
                          ? IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteFile(index),
                            )
                          : const Icon(Icons.download, color: Colors.green),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Tapped on ${file.path.split('/').last}")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
