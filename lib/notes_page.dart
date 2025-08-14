import 'dart:typed_data';
import 'dart:io' as io show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';
import 'animated_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesPage extends StatefulWidget {
  final String year;
  final String semester;
  final String subject;
  final String role;   // 'teacher' or 'student'
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
  final supabase = SupabaseConfig.client;
  bool _loading = false;
  List<Map<String, dynamic>> _notes = [];

  final Map<String, String> _mime = const {
    'pdf': 'application/pdf',
    'doc': 'application/msword',
    'docx':
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'ppt': 'application/vnd.ms-powerpoint',
    'pptx':
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'txt': 'text/plain',
  };

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    setState(() => _loading = true);
    try {
      final data = await supabase
          .from('notes')
          .select()
          .eq('year', widget.year)
          .eq('semester', widget.semester)
          .eq('subject', widget.subject)
          .order('created_at', ascending: false);
      setState(() => _notes = List<Map<String, dynamic>>.from(data));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Load error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _pickAndUpload() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: _mime.keys.toList(),
      withData: kIsWeb, // ensure bytes on web
    );
    if (res == null) return;

    final name = res.files.single.name;
    final ext = name.split('.').last.toLowerCase();
    final contentType = _mime[ext] ?? 'application/octet-stream';
    final bucket = supabase.storage.from('notes'); // bucket name: notes
    final objectPath =
        '${widget.year}/${widget.semester}/${widget.subject}/$name';

    setState(() => _loading = true);
    try {
      if (kIsWeb) {
        final Uint8List? bytes = res.files.single.bytes;
        if (bytes == null) throw Exception('No file bytes');
        await bucket.uploadBinary(
          objectPath,
          bytes,
          fileOptions: FileOptions(contentType: contentType, upsert: true),
        );
      } else {
        final path = res.files.single.path!;
        await bucket.upload(
          objectPath,
          io.File(path),
          fileOptions: FileOptions(contentType: contentType, upsert: true),
        );
      }

      // Public URL
      final publicUrl = bucket.getPublicUrl(objectPath);

      // Save row
      await supabase.from('notes').insert({
        'year': widget.year,
        'semester': widget.semester,
        'subject': widget.subject,
        'file_url': publicUrl,
        'uploaded_by': widget.userId,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Uploaded ✅')));
      await _fetchNotes();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _deleteNote(String fileUrl, String id) async {
    if (widget.role != 'teacher') return;
    try {
      // Derive object path from public URL (everything after /object/public/notes/)
      final uri = Uri.parse(fileUrl);
      final idx = uri.path.indexOf('/object/public/notes/');
      if (idx == -1) throw Exception('Invalid storage URL');
      final objectPath = uri.path.substring(idx + '/object/public/notes/'.length);

      await supabase.storage.from('notes').remove([objectPath]);
      await supabase.from('notes').delete().eq('id', id);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Deleted ✅')));
      await _fetchNotes();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  Future<void> _openUrl(String url) async {
    final parsed = Uri.parse(url);
    if (!await launchUrl(parsed, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Could not open file')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTeacher = widget.role.toLowerCase() == 'teacher';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      floatingActionButton: isTeacher
          ? FloatingActionButton.extended(
              onPressed: _loading ? null : _pickAndUpload,
              icon: const Icon(Icons.upload_file),
              label: Text(_loading ? 'Uploading...' : 'Upload'),
            )
          : null,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? const Center(
                  child: Text('No notes yet',
                      style: TextStyle(color: Colors.grey)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final n = _notes[index];
                    final fileUrl = n['file_url'] as String;
                    final id = (n['id'] ?? '').toString();
                    final fileName = Uri.decodeFull(fileUrl.split('/').last);

                    return AnimatedTile(
                      index: index,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.insert_drive_file,
                              color: Colors.deepPurple),
                          title: Text(
                            fileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${widget.year} • ${widget.semester}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Open',
                                icon: const Icon(Icons.open_in_new),
                                onPressed: () => _openUrl(fileUrl),
                              ),
                              if (isTeacher)
                                IconButton(
                                  tooltip: 'Delete',
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteNote(fileUrl, id),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
