import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // المنطقة العلوية: DrawerHeader مع التدرج والصورة والنصوص
          Container(
            width: double.infinity, // تغطية العرض بالكامل
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'imag/ab.jpg',
                    ), // تحقق من صحة المسار
                  ),
                  SizedBox(height: 10),
                  Text(
                    "عبدالشكور",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "مرحبا بك في متجري",
                    style: TextStyle(
                      color: Color.fromARGB(208, 255, 255, 255),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // عناصر القائمة
          ListTile(
            leading: const Icon(Icons.home, color: Colors.blue),
            title: const Text('الرئيسية'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.green),
            title: const Text('السلة'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/cart');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag,
                color: Colors.blue), // أيقونة للمنتجات باللون الأزرق
            title: const Text("المنتجات"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/product');
            },
          ),
        

          ListTile(
            leading: const Icon(Icons.person, color: Colors.orange),
            title: const Text('الحساب الشخصي'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Color(0xFF7F00FF)),
            title: const Text('إتمام الشراء'),
            onTap: () {
              Navigator.pushNamed(context, '/checkout');
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text('تتبع الطلب'),
            onTap: () {
              Navigator.pushNamed(context, '/order-tracking');
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings, color: Colors.blue),
            title: const Text('الإعدادات'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Custom Drawer Example")),
        drawer: const CustomDrawer(),
        body: const Center(child: Text("Body Content Here")),
      ),
    );
  }
}
