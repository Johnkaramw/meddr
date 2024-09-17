import 'package:flutter/material.dart';

class DeficiencyPage extends StatefulWidget {
  @override
  _DeficiencyPageState createState() => _DeficiencyPageState();
}

class _DeficiencyPageState extends State<DeficiencyPage> {
  final List<String> deficiencies = [];
  final TextEditingController _deficiencyController = TextEditingController();

  void _addDeficiency(String deficiency) {
    setState(() {
      deficiencies.add(deficiency);
      _deficiencyController.clear();
    });
  }

  void _showAddDeficiencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة نقص جديد'),
          content: TextField(
            controller: _deficiencyController,
            decoration: InputDecoration(hintText: 'أدخل اسم النقص'),
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
                String deficiency = _deficiencyController.text;
                if (deficiency.isNotEmpty) {
                  _addDeficiency(deficiency);
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

  void _showDeleteDeficiencyDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تأكيد حذف النقص'),
          content: Text('هل أنت متأكد من أنك تريد حذف هذا النقص؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  deficiencies.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('حذف'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة النواقص'),
      ),
      body: ListView.builder(
        itemCount: deficiencies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(deficiencies[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteDeficiencyDialog(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDeficiencyDialog,
        child: Text('نواقص'),
        backgroundColor: Colors.orangeAccent,
        tooltip: 'إضافة نقص جديد',
      ),
    );
  }
}
