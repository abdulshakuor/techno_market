import 'package:activity1/CustomDrawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحساب الشخصي'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('عبد الشكور'),
              subtitle: Text('abdul@gmail.com'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('رقم الهاتف'),
              subtitle: Text('772835604'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text('العنوان'),
              subtitle: Text('اليمن، تعز مدينة النور'),
            ),
          ],
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
}
