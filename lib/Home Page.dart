import 'package:flutter/material.dart';
import 'package:activity1/CustomDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// لمعرفة الصفحة الحالية
  bool _isSearching = false; // متغير لتمكين أو تعطيل البحث
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> products = [
    {
      'name': ' جهاز لابتوب ',
      'image': 'imag/yyy.jpeg',
      'price': '3000',
    },
    {
      'name': ' هاتف هونور',
      'image': 'imag/ww.jpg',
      'price': '300',
    },
    {
      'name': 'هاتف جلاكسي ',
      'image': 'imag/rr.jpg',
      'price': '400',
    },
    {
      'name': ' لابتوب محمول',
      'image': 'imag/uu.jpeg',
      'price': '1100',
    },
    {
      'name': ' هاتف ايفون',
      'image': 'imag/fff.jpg',
      'price': '700',
    },
    {
      'name': ' ايباد ',
      'image': 'imag/qq.jpeg',
      'price': '600',
    },
    {
      'name': ' ايفون ',
      'image': 'imag/tt.jpg',
      'price': '900',
    },
    {
      'name': ' لابتوب محمول ',
      'image': 'imag/pp.jpeg',
      'price': '1200',
    },
    {
      'name': 'ايفون برو ماكس ',
      'image': 'imag/mm.jpg',
      'price': '500',
    },

    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'بحث...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                autofocus: true,
              )
            : const Text('المنتجات'),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.clear : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear(); // مسح النص عند إيقاف البحث
                }
              });
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(), // اضافة Drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8, // التحكم في شكل الخلايا
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              // إذا كان هناك نص في شريط البحث
              if (_searchController.text.isNotEmpty &&
                  !product['name']!
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())) {
                return Container(); // إخفاء المنتجات التي لا تطابق البحث
              }

              return GestureDetector(
                onTap: () {
                  // الانتقال إلى صفحة تفاصيل المنتج مع تمرير البيانات
                  Navigator.pushNamed(
                    context,
                    '/product',
                    arguments: product,
                  );
                },
                child: Card(
                  elevation: 8, // زيادة الارتفاع لإبراز البطاقة
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // زوايا البطاقة المستديرة
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // صورة المنتج مع تأثير
                      Stack(
                        children: [
                          // يعمل على اقتصاص الحواف الخارجية للعنصر بناءً على القيم المحددة.
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.asset(
                              product['image']!,
                              height: 70,
                              // تضبط الصورة لتغطي كامل المساحة المتاحة للعنصر
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 140,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // شارة السعر
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '\$${product['price']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // النصوص والمعلومات
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '4.5', // تقييم افتراضي
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // زر إضافة إلى السلة
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/cart');
                            // إضافة المنتج إلى السلة
                            print('تم إضافة المنتج إلى السلة!');
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white, // لون الأيقونة
                          ),
                          label: const Text(
                            'إضافة إلى السلة',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 116, 67, 199),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
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
