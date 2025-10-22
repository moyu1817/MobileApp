import 'package:flutter/material.dart';

class AddStaffPage extends StatefulWidget {
  @override
  _AddStaffPageState createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  String? statusValue = 'Available';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SPORT APP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Placeholder with Upload and Bin Icons Below
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.image,
                          size: 80,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/upload.png',
                              width: 30,
                              height: 30,
                            ),
                            onPressed: () {
                              // Handle image upload
                            },
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            icon: Image.asset(
                              'assets/images/bin.png',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              // Handle image deletion
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Name Field Row
                _buildTextFieldRow("Name :", nameController),
                SizedBox(height: 16),

                // Status Dropdown Row with Conditional Color
                _buildDropdownRow("Status :", statusValue),
                SizedBox(height: 16),

                // Info Field Row
                _buildTextFieldRow("Info :", infoController),
                SizedBox(height: 20),
              ],
            ),
          ),

          // Positioned "Add" button in the bottom right corner above the nav bar
          Positioned(
            bottom: 20,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldRow(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label),
        ),
        Expanded(
          flex: 6,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownRow(String label, String? value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label),
        ),
        Expanded(
          flex: 6,
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                child: Text(
                  'Available',
                  style: TextStyle(color: Colors.green),
                ),
                value: 'Available',
              ),
              DropdownMenuItem(
                child: Text(
                  'Disabled',
                  style: TextStyle(color: Colors.grey),
                ),
                value: 'Disabled',
              ),
            ],
            onChanged: (newValue) {
              setState(() {
                statusValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Do you want to add this item?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context, {
                        "name": nameController.text,
                        "imagePath": 'path/to/default/image.png',
                        "status": statusValue,
                        "info": infoController.text,
                        "color": statusValue == "Available"
                            ? Color(0xFF2EA64E)
                            : Color(0xFFFF0000),
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
