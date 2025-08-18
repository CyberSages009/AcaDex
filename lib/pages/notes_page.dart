import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/storage_service.dart';

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
  final StorageService storage = StorageService();
  String? uploadedFileUrl;
  bool isUploading = false;

  Future<void> pickAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);

      setState(() => isUploading = true);

      final url = await storage.uploadFile(
        file: file,
        bucket: 'notes',
        path: 'uploads/${widget.userId}/${widget.year}_${widget.semester}_${widget.subject}',
      );

      setState(() {
        isUploading = false;
        uploadedFileUrl = url;
      });

      if (!mounted) return;

      if (url != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ File uploaded successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Upload failed")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes - ${widget.subject}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Pick & Upload File"),
              onPressed: pickAndUploadFile,
            ),
            const SizedBox(height: 20),
            if (isUploading) const CircularProgressIndicator(),
            if (uploadedFileUrl != null) ...[
              const SizedBox(height: 20),
              Text("Uploaded File URL:",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SelectableText(uploadedFileUrl!,
                  style: const TextStyle(color: Colors.blue)),
            ],
          ],
        ),
      ),
    );
  }
}
