
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  // ✅ تسجيل الدخول عبر البريد وكلمة المرور
  Future<void> signInWithEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home'); // انتقال للصفحة الرئيسية
    } catch (e) {
      showErrorDialog(context, 'فشل تسجيل الدخول', e.toString());
    }
  }

  // ✅ تسجيل الدخول عبر Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // إلغاء تسجيل الدخول

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/home'); // نجاح وتوجيه للصفحة الرئيسية
    } catch (e) {
      showErrorDialog(context, 'فشل تسجيل الدخول', e.toString());
    }
  }

  // ✅ رسالة خطأ منبثقة
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('حسنًا'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(radius: 50, backgroundImage: AssetImage('imag/aa.jpg')),
                  const SizedBox(height: 20),
                  const Text('مرحبًا بعودتك!', style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  
                  // 📩 إدخال البريد الإلكتروني
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true, fillColor: Colors.white, hintText: 'البريد الإلكتروني',
                      prefixIcon: const Icon(Icons.email, color: Colors.blue),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // 🔑 إدخال كلمة المرور
                  TextField(
                    controller: passwordController, obscureText: true,
                    decoration: InputDecoration(
                      filled: true, fillColor: Colors.white, hintText: 'كلمة المرور',
                      prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ زر تسجيل الدخول
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () => signInWithEmail(context),
                    child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),

                  // ✅ زر تسجيل الدخول عبر Google
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => signInWithGoogle(context),
                    icon: Image.asset('assets/google_logo.png', height: 24),
                    label: const Text('تسجيل الدخول عبر Google', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: const Text(
                      'ليس لديك حساب؟ أنشئ واحدًا الآن',
                      style: TextStyle(color: Colors.white70, fontSize: 14, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

