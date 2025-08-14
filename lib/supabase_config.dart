import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://YOUR-PROJECT-REF.supabase.co'; // TODO: replace
  static const String supabaseAnonKey = 'YOUR-ANON-KEY'; // TODO: replace

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
