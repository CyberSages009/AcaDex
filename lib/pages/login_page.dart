import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'year_page.dart';
import '../widgets/animated_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String role = "student";
  bool isLoading = false;
  bool isLogin = true;

  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(); // start animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    setState(() => isLoading = true);
    try {
      if (isLogin) {
        final response = await Supabase.instance.client.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!mounted) return;
        if (response.user != null) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, a, __) => YearPage(
                role: role,
                userId: response.user!.id,
              ),
              transitionsBuilder: (_, a, __, child) =>
                  FadeTransition(opacity: a, child: child),
            ),
          );
        }
      } else {
        final response = await Supabase.instance.client.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!mounted) return;
        if (response.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signup successful! Please log in.')),
          );
          setState(() => isLogin = true);
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Sign Up"),
        flexibleSpace: const _GradientBar(),
      ),
      body: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _slide,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 40),

              AnimatedTile(
                title: "Email",
                subtitle: "Enter your email",
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "example@mail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              AnimatedTile(
                title: "Password",
                subtitle: "Enter your password",
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "••••••••",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              AnimatedTile(
                title: "Role",
                subtitle: "Choose your role",
                child: DropdownButtonFormField<String>(
                  value: role,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (val) => setState(() => role = val!),
                  items: const [
                    DropdownMenuItem(value: "student", child: Text("Student")),
                    DropdownMenuItem(value: "teacher", child: Text("Teacher")),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              AnimatedTile(
                title: "",
                subtitle: "",
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color(0xFF6750A4),
                  ),
                  onPressed: isLoading ? null : _authenticate,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          isLogin ? "Login" : "Sign Up",
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),

              const SizedBox(height: 12),

              AnimatedTile(
                title: "",
                subtitle: "",
                child: TextButton(
                  onPressed: () => setState(() => isLogin = !isLogin),
                  child: Text(
                    isLogin
                        ? "Don't have an account? Sign Up"
                        : "Already have an account? Login",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientBar extends StatelessWidget {
  const _GradientBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF6750A4), Color(0xFF1180FF)]),
      ),
    );
  }
}
