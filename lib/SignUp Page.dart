
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ✅ إنشاء حساب جديد في Firebase
  Future<void> signUp(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home'); // نجاح الانتقال للصفحة الرئيسية
    } catch (e) {
      showErrorDialog(context, 'فشل إنشاء الحساب', e.toString());
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
          gradient: LinearGradient(colors: [Colors.teal, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(radius: 50, backgroundImage: AssetImage('imag/aa.jpg')),
                const SizedBox(height: 20),
                const Text('أنشئ حسابًا جديدًا', style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),
                TextField(controller: emailController, decoration: InputDecoration(hintText: 'البريد الإلكتروني')),
                const SizedBox(height: 20),
                TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(hintText: 'كلمة المرور')),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: () => signUp(context), child: const Text('إنشاء الحساب')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

