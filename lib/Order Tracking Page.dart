import 'package:flutter/material.dart';
import 'package:activity1/CustomDrawer.dart';

class OrderTrackingPage extends StatelessWidget {
  final Map<String, String> order = {
    'orderId': '#12345',
    'status': 'قيد الشحن',
    'estimatedDelivery': '3 أيام',
    'shippingInfo': 'شركة الشحن: DHL\nرقم التتبع: 987654321'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع الطلب'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات الطلب
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم الطلب: ${order['orderId']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'حالة الطلب: ${order['status']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: order['status'] == 'تم التسليم'
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'الوقت المتوقع للتوصيل: ${order['estimatedDelivery']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // مخطط حالة الطلب
            const Text(
              'تقدم الطلب:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Stepper(
              currentStep: 1, // تحديد الخطوة الحالية
              steps: const [
                Step(
                  title: Text('قيد المعالجة'),
                  content: Text('تم استلام الطلب ويتم معالجته.'),
                  isActive: true,
                  state: StepState.complete,
                ),
                Step(
                  title: Text('قيد الشحن'),
                  content: Text('الطلب الآن في طريقه إلى عنوانك.'),
                  isActive: true,
                  state: StepState.indexed,
                ),
                Step(
                  title: Text('تم التسليم'),
                  content: Text('تم تسليم الطلب بنجاح.'),
                  isActive: false,
                  state: StepState.indexed,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // معلومات الشحن
            const Text(
              'معلومات الشحن:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    // تستخدم لتحديد إزاحة العنصر في الاتجاهين الأفقي (x) والرأسي (y)
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                order['shippingInfo']!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: const Color.fromARGB(255, 117, 33, 243),

      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         onPressed: () {
      //           // كود للانتقال إلى الصفحة الرئيسية أو أي صفحة أخرى
      //           Navigator.pushReplacementNamed(context, '/home');
      //         },
      //         icon: const Icon(Icons.home, color: Colors.white),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           // كود للانتقال إلى صفحة السلة أو أي صفحة أخرى
      //           Navigator.pushReplacementNamed(context, '/cart');
      //         },
      //         icon: const Icon(Icons.shopping_cart, color: Colors.white),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           // كود للانتقال إلى صفحة الطلبات أو أي صفحة أخرى
      //           Navigator.pushReplacementNamed(context, '/order-tracking');
      //         },
      //         icon: const Icon(Icons.receipt, color: Colors.white),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
