import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://oxtdhcljrssglmteftce.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94dGRoY2xqcnNzZ2xtdGVmdGNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwNzQwNDEsImV4cCI6MjA3MDY1MDA0MX0.nQwRjdoGb8A5JDOseJgaeeUQVNa54uqyawaXxg-RqyA",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
