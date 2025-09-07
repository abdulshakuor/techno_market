import 'package:flutter/material.dart';
import 'package:activity1/CustomDrawer.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'الإعدادات العامة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    _buildSettingItem(
                      context,
                      icon: Icons.person,
                      title: 'الملف الشخصي',
                      subtitle: 'قم بتحديث بياناتك الشخصية',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/profile');
                      },
                    ),
                    _buildSettingItem(
                      context,
                      icon: Icons.notifications,
                      title: 'الإشعارات',
                      subtitle: 'تخصيص إعدادات الإشعارات',
                      onTap: () {
                        _showInfoDialog(context, 'إعدادات الإشعارات');
                      },
                    ),
                    _buildSettingItem(
                      context,
                      icon: Icons.lock,
                      title: 'الخصوصية',
                      subtitle: 'إعدادات الخصوصية',
                      onTap: () {
                        _showInfoDialog(context, 'إعدادات الخصوصية');
                      },
                    ),
                    _buildSettingItem(
                      context,
                      icon: Icons.language,
                      title: 'اللغة',
                      subtitle: 'اختر اللغة المناسبة',
                      onTap: () {
                        _showInfoDialog(context, 'إعدادات اللغة');
                      },
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    _buildSettingItem(
                      context,
                      icon: Icons.logout,
                      title: 'تسجيل الخروج',
                      subtitle: 'تسجيل الخروج من الحساب',
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                      iconColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 117, 33, 243),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // كود للانتقال إلى الصفحة الرئيسية أو أي صفحة أخرى
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: const Icon(Icons.home, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // كود للانتقال إلى صفحة السلة أو أي صفحة أخرى
                Navigator.pushReplacementNamed(context, '/cart');
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // كود للانتقال إلى صفحة الطلبات أو أي صفحة أخرى
                Navigator.pushReplacementNamed(context, '/order-tracking');
              },
              icon: const Icon(Icons.receipt, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = Colors.blueAccent,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text('هذه الميزة قيد التطوير.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد تسجيل الخروج'),
        content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // العودة
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}
