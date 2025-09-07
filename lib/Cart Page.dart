import 'package:flutter/material.dart';
import 'package:activity1/CustomDrawer.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems = [
    {'name': 'هاتف سامسونج', 'price': '100'},
    {'name': 'هاتف هونور', 'price': '150'},
  ]; // منتجات مبدئية في السلة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'السلة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 117, 33, 243),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: const Icon(Icons.home, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/cart');
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/order-tracking');
              },
              icon: const Icon(Icons.receipt, color: Colors.white),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          // خلفية متدرجة لتجميل الشاشة
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // محتوى الشاشة
          Column(
            children: [
              Expanded(
                child: cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          'السلة فارغة',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                child: Text(
                                  item['name']![0], // الحرف الأول من المنتج
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(item['name']!),
                              subtitle: Text('السعر: \$${item['price']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      // حذف المنتج من السلة
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('تأكيد الحذف'),
                                            content: const Text(
                                                'هل تريد حذف هذا المنتج من السلة؟'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('إلغاء'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  cartItems.removeAt(index);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('حذف'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      // التحقق من الطلب
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('تحقق الطلب'),
                                            content: const Text(
                                                'تم التحقق من الطلب بنجاح!'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('حسنًا'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (cartItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/checkout',
                            arguments: {
                              'cartItems': cartItems,
                              'totalPrice': cartItems.fold<double>(
                                0,
                                (sum, item) =>
                                    sum + double.parse(item['price']!),
                                // يتم جمع المجموع الحالي مع السعر المحوّل إلى نوع double.
                              ),
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'إتمام الشراء',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          cartItems.clear(); // إفراغ السلة
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'إفراغ السلة',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
