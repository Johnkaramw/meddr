import 'package:flutter/material.dart';
import 'package:meddr/MedicinePage%20.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // التأكد من تهيئة Flutter
  runApp(VetApp());
}

class VetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إزالة علامة الـ Debug
      home: DoctorProfilePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.orangeAccent),
      ),
    );
  }
}

class DoctorProfilePage extends StatelessWidget {
  final String doctorName = "د. أحمد سعيد";
  final String phoneNumber = "123456789";
  final String clinicLocation = "القاهرة، مصر";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الصفحة الشخصية للطبيب',
          style: TextStyle(
            color: Color.fromARGB(255, 38, 236, 11),
            fontSize: 20,
          ),
        ),
        centerTitle: true, // لجعل العنوان في منتصف الـ AppBar
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.2,
                  backgroundImage: AssetImage('assets/download.png'),
                ),
                SizedBox(height: 16),
                Text(
                  doctorName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "رقم الجوال: $phoneNumber",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.teal[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "أماكن العيادة: $clinicLocation",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.teal[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicinePage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
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
