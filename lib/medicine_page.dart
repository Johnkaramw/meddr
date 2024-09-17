import 'package:flutter/material.dart';
import 'deficiency_page.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  final List<String> medicines = [];

  final Map<String, int> medicineQuantities = {};

  final Map<String, double> medicinePrices = {};

  double totalMoneySpent = 0.0; // المال المصروف على شراء الأدوية
  double totalMoneyEarned = 0.0; // المال المكتسب من بيع الأدوية
  String searchQuery = ''; // متغير لتخزين النص المدخل في البحث

  // إضافة كميات جديدة للدواء
  void addExistingMedicineQuantity(String medicineName, int quantity) {
    setState(() {
      medicineQuantities[medicineName] =
          (medicineQuantities[medicineName]! + quantity);
      totalMoneySpent += medicinePrices[medicineName]! * quantity;
    });
  }

  // إضافة دواء جديد
  void addMedicine(String name, int quantity, double price) {
    setState(() {
      medicines.add(name);
      medicineQuantities[name] = quantity;
      medicinePrices[name] = price;
      totalMoneySpent += price * quantity;
    });
  }

  // استخدام أو بيع الدواء
  void useMedicine(String medicineName, int amountUsed) {
    setState(() {
      if (medicineQuantities[medicineName]! >= amountUsed) {
        medicineQuantities[medicineName] =
            (medicineQuantities[medicineName]! - amountUsed);
        totalMoneyEarned += medicinePrices[medicineName]! * amountUsed;
      }
    });
  }

  // حذف دواء
  void deleteMedicine(String medicineName) {
    setState(() {
      double price = medicinePrices[medicineName]!;
      int quantity = medicineQuantities[medicineName]!;
      medicines.remove(medicineName);
      medicineQuantities.remove(medicineName);
      medicinePrices.remove(medicineName);
      totalMoneySpent -= price * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<String> filteredMedicines = medicines
        .where((medicine) =>
            medicine.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'صفحة الأدوية',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(132.0), // تعديل ارتفاع الـ AppBar
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'ابحث عن علاج...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/deficiency');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 226, 101, 101),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.01,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'نواقص',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.030,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/pngtree-some-medicine-and-pills-with-an-osteopathic-syringe-in-it-image_13222690.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'المشتريات: $totalMoneySpent جنيه',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.teal[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'المبيعات: $totalMoneyEarned جنيه',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.teal[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredMedicines.length,
                    itemBuilder: (context, index) {
                      String medicineName = filteredMedicines[index];
                      int remaining = medicineQuantities[medicineName]!;
                      double price = medicinePrices[medicineName]!;

                      return Card(
                        color: Colors.teal[50],
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Center(
                            child: Text(
                              medicineName,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: Colors.teal[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'السعر: $price جنيه',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              Text(
                                'المتبقي: $remaining',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.teal),
                                onPressed: () {
                                  _showUseMedicineDialog(medicineName);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.orange),
                                onPressed: () {
                                  _showAddMedicineQuantityDialog(medicineName);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteMedicineDialog(medicineName);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
        double screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          title: Text('إضافة علاج جديد',
              style: TextStyle(fontSize: screenWidth * 0.05)),
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
                if (medicineName.isNotEmpty && quantity > 0 && price > 0.0) {
                  addMedicine(medicineName, quantity, price);
                  Navigator.of(context).pop();
                }
              },
              child: Text('إضافة'),
            ),
          ],
        );
      },
    );
  }

  void _showAddMedicineQuantityDialog(String medicineName) {
    int quantity = 0;

    showDialog(
      context: context,
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          title: Text('إضافة كمية جديدة للدواء',
              style: TextStyle(fontSize: screenWidth * 0.05)),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'أدخل الكمية'),
            onChanged: (value) {
              quantity = int.tryParse(value) ?? 0;
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
                if (quantity > 0) {
                  addExistingMedicineQuantity(medicineName, quantity);
                  Navigator.of(context).pop();
                }
              },
              child: Text('إضافة'),
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
        double screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          title: Text('استخدام/بيع دواء',
              style: TextStyle(fontSize: screenWidth * 0.05)),
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
                if (amountUsed > 0) {
                  useMedicine(medicineName, amountUsed);
                  Navigator.of(context).pop();
                }
              },
              child: Text('استخدام'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteMedicineDialog(String medicineName) {
    showDialog(
      context: context,
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          title:
              Text('حذف دواء', style: TextStyle(fontSize: screenWidth * 0.05)),
          content: Text('هل تريد بالتأكيد حذف هذا الدواء؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                deleteMedicine(medicineName);
                Navigator.of(context).pop();
              },
              child: Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}
