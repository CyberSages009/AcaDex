import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// Upload file to Supabase Storage
  Future<String?> uploadFile({
    required File file,
    required String bucket,
    required String path,
    bool addTimestamp = true, // optional
  }) async {
    try {
      // Extract original file name
      String fileName = file.path.split('/').last;

      // ✅ Sanitize filename (remove invalid chars)
      fileName = fileName.replaceAll(RegExp(r'[^\w\.-]'), '_');

      // ✅ Optionally append timestamp to prevent overwrites
      if (addTimestamp) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final ext = fileName.contains('.')
            ? fileName.substring(fileName.lastIndexOf('.'))
            : '';
        final base = fileName.contains('.')
            ? fileName.substring(0, fileName.lastIndexOf('.'))
            : fileName;
        fileName = "${base}_$timestamp$ext";
      }

      final filePath = '$path/$fileName';

      // Upload with upsert (overwrite = true if same file exists)
      await supabase.storage.from(bucket).upload(
            filePath,
            file,
            fileOptions: const FileOptions(upsert: true),
          );

      // ✅ Get public URL back
      final publicUrl = supabase.storage.from(bucket).getPublicUrl(filePath);

      print("✅ Uploaded: $publicUrl");
      return publicUrl;
    } catch (e) {
      print("❌ Upload failed: $e");
      return null;
    }
  }

  /// Download file from Supabase
  Future<File?> downloadFile({
    required String bucket,
    required String path,
    required String savePath,
  }) async {
    try {
      final bytes = await supabase.storage.from(bucket).download(path);
      final file = File(savePath);
      await file.writeAsBytes(bytes);
      print("✅ File downloaded: ${file.path}");
      return file;
    } catch (e) {
      print("❌ Download failed: $e");
      return null;
    }
  }

  /// Delete file from Supabase
  Future<bool> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      await supabase.storage.from(bucket).remove([path]);
      print("🗑️ File deleted: $path");
      return true;
    } catch (e) {
      print("❌ Delete failed: $e");
      return false;
    }
  }
}
