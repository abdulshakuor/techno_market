import 'package:flutter/material.dart';
import 'package:activity1/CustomDrawer.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  // تُستخدم لإدارة النصوص المدخلة في حقول الإدخال ومراقبتها.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _paymentMethod = 'الدفع عند الاستلام';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الشراء'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان القسم
              _sectionTitle('بيانات الشحن:'),
              _customTextField(
                controller: _nameController,
                label: 'الاسم',
                icon: Icons.person,
              ),
              _customTextField(
                controller: _addressController,
                label: 'العنوان',
                icon: Icons.location_on,
              ),
              _customTextField(
                controller: _phoneController,
                label: 'رقم الهاتف',
                icon: Icons.phone,
                inputType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              // قسم وسيلة الدفع
              _sectionTitle('وسيلة الدفع:'),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                items: const [
                  DropdownMenuItem(
                    value: 'الدفع عند الاستلام',
                    child: Text('الدفع عند الاستلام'),
                  ),
                  DropdownMenuItem(
                    value: 'البطاقة الائتمانية',
                    child: Text('البطاقة الائتمانية'),
                  ),
                  DropdownMenuItem(
                    value: ' بطاقة مستر كارد',
                    child: Text('بطاقة مستر كارد'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // قسم مراجعة الطلب
              _sectionTitle('مراجعة الطلب:'),
              _orderSummary(),
              const SizedBox(height: 30),

              // زر تأكيد الطلب
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم تأكيد الطلب بنجاح!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: const Color(0xFF7F00FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'تأكيد الطلب',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت عنوان قسم
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF7F00FF),
        ),
      ),
    );
  }

  // ويدجت حقل نص مخصص
  Widget _customTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF7F00FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'يرجى إدخال $label';
          }
          return null;
        },
      ),
    );
  }

  // ويدجت مراجعة الطلب
  Widget _orderSummary() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summaryRow('إجمالي الطلب:', '\$300'),
            const Divider(color: Colors.grey),
            _summaryRow('وسيلة الدفع:', _paymentMethod),
          ],
        ),
      ),
    );
  }

  // ويدجت صف ملخص الطلب
  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF7F00FF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
