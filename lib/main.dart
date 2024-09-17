import 'package:flutter/material.dart';
import 'package:meddr/medicine_page.dart';
import 'package:meddr/deficiency_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // التأكد من تهيئة Flutter
  runApp(VetApp());
}

class VetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إزالة علامة الـ Debug
      initialRoute: '/',
      routes: {
        '/': (context) => DoctorProfilePage(),
        '/medicine': (context) => MedicinePage(),
        '/deficiency': (context) => DeficiencyPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.orangeAccent),
      ),
    );
  }
}

class DoctorProfilePage extends StatelessWidget {
  final String doctorName = "د. أحمد سعيد";
  final String phoneNumber = "01206256448";
  final String clinicLocation = " القاهرة ، سوهاج ، طما ";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 28.0), // تعديل المسافة هنا
          child: const Text(
            'DoseDiary',
            style: TextStyle(
              color: Color.fromARGB(255, 125, 193, 238),
              fontSize: 30,
            ),
          ),
        ),
        centerTitle: true, // لجعل العنوان في منتصف الـ AppBar
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.4,
                  backgroundImage: const AssetImage('assets/لوجو.jpg'),
                ),
                const SizedBox(height: 16),
                Text(
                  doctorName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "رقم الجوال: $phoneNumber",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.teal[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "أماكن الصيدلية: $clinicLocation",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.teal[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/medicine', // استخدم المسار المسجل
                    );
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      'ابدأ',
                      style: TextStyle(fontSize: screenWidth * 0.05),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
