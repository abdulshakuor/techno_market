import 'package:activity1/CustomDrawer.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // استلام البيانات المرسلة
    final product =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // في حالة عدم وجود البيانات
    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('المنتج غير موجود'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home'); // اسم الصفحة الرئيسية.
            },
          ),
        ),
        drawer: CustomDrawer(), 
        body: const Center(child: Text('لا توجد معلومات عن المنتج')),
      );
    }

    // عرض تفاصيل المنتج مع تنسيقات جذابة
    return Scaffold(
      backgroundColor: Colors.grey[100], // خلفية الصفحة
      appBar: AppBar(
        title: Text(product['name']!),
        backgroundColor: Colors.deepPurple, // لون جميل لـ AppBar
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent], // التدرج اللوني
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // العودة إلى الصفحة الرئيسية
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المنتج مع تأثير الظل
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  product['image']!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Image(
                      image: AssetImage(
                          'assets/images/placeholder.jpg'), // صورة احتياطية
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // اسم المنتج
              Text(
                product['name']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),

              // عرض السعر
              Text(
                'السعر: \$${product['price']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // وصف المنتج (مثال)
              Text(
                'وصف المنتج: هذا المنتج هو منتج عالي الجودة يتميز بتصميم عصري ومواصفات ممتازة، مثالي للاستخدام اليومي.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),

              // زر إضافة إلى السلة
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // إضافة المنتج إلى السلة
                    Navigator.pushNamed(context, '/cart');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // لون الزر
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'إضافة إلى السلة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
}
