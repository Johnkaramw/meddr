import 'package:flutter/material.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  final List<String> medicines = [
    'دواء 1',
    'دواء 2',
    'دواء 3',
  ];

  final Map<String, int> medicineQuantities = {
    'دواء 1': 100,
    'دواء 2': 100,
    'دواء 3': 100,
  };

  final Map<String, double> medicinePrices = {
    'دواء 1': 50.0,
    'دواء 2': 75.0,
    'دواء 3': 100.0,
  };

  String searchQuery = ''; // متغير لتخزين النص المدخل في البحث

  void addMedicine(String name, int quantity, double price) {
    setState(() {
      medicines.add(name);
      medicineQuantities[name] = quantity;
      medicinePrices[name] = price;
    });
  }

  void useMedicine(String medicineName, int amountUsed) {
    setState(() {
      medicineQuantities[medicineName] =
          (medicineQuantities[medicineName]! - amountUsed);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // الأدوية التي تطابق نص البحث
    final List<String> filteredMedicines = medicines
        .where((medicine) =>
            medicine.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة الأدوية'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'ابحث عن علاج...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredMedicines.length,
        itemBuilder: (context, index) {
          String medicineName = filteredMedicines[index];
          int remaining = medicineQuantities[medicineName]!;
          double price = medicinePrices[medicineName]!;
          return Card(
            color: Colors.teal[50],
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                medicineName,
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              subtitle: Text(
                'المتبقي: $remaining\nالسعر: $price جنيه',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              trailing: IconButton(
                icon: Icon(Icons.remove, color: Colors.teal),
                onPressed: () {
                  _showUseMedicineDialog(medicineName);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMedicineDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
        tooltip: 'إضافة علاج جديد',
      ),
    );
  }

  void _showAddMedicineDialog() {
    String medicineName = '';
    int quantity = 0;
    double price = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة علاج جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'اسم العلاج'),
                onChanged: (value) {
                  medicineName = value;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'الكمية المتاحة'),
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 0;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'السعر'),
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                if (medicineName.isNotEmpty && quantity > 0 && price > 0) {
                  addMedicine(medicineName, quantity, price);
                }
                Navigator.of(context).pop();
              },
              child: Text('إضافة'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showUseMedicineDialog(String medicineName) {
    int amountUsed = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('استخدام $medicineName'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'أدخل الكمية المستخدمة'),
            onChanged: (value) {
              amountUsed = int.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                useMedicine(medicineName, amountUsed);
                Navigator.of(context).pop();
              },
              child: Text('تأكيد'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        );
      },
    );
  }
}
