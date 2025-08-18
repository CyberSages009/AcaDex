import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://oxtdhcljrssglmteftce.supabase.co'; 
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94dGRoY2xqcnNzZ2xtdGVmdGNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwNzQwNDEsImV4cCI6MjA3MDY1MDA0MX0.nQwRjdoGb8A5JDOseJgaeeUQVNa54uqyawaXxg-RqyA';

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
