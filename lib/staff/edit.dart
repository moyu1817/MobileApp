import 'package:flutter/material.dart';

class EditStaffPage extends StatefulWidget {
  final Map<String, dynamic>? item; // Optional item for editing

  const EditStaffPage({super.key, required this.item});

  @override
  _EditStaffPageState createState() => _EditStaffPageState();
}

class _EditStaffPageState extends State<EditStaffPage> {
  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _infoController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing item data if available
    _nameController = TextEditingController(text: widget.item?["name"] ?? "");
    _infoController = TextEditingController(text: widget.item?["info"] ?? "");
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nameController.dispose();
    _infoController.dispose();
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            widget.item?["imagePath"] ??
                                'assets/images/default.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Placeholder for Upload and Delete Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/upload.png', // Path for upload icon
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
                              'assets/images/bin.png', // Path for bin icon
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
                _buildTextFieldRow("Name  :", _nameController, false),
                SizedBox(height: 20),
                // Info Field Row
                _buildTextFieldRow("Info      :", _infoController, true),
                SizedBox(height: 20),
              ],
            ),
          ),
          // Positioned "Edit" button in the bottom right corner
          Positioned(
            bottom: 20,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldRow(
      String label, TextEditingController controller, bool isInfo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(label),
        ),
        Expanded(
          flex: 6,
          child: TextField(
            controller: controller,
            maxLines: isInfo ? 5 : 1,
            minLines: isInfo ? 3 : 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
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
          title: const Center(
            child: Text(
              'Do you want to edit this item?',
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
                      Navigator.of(context).pop(); // Close dialog
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Center(
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
                      // Return updated item data to AllStaff page
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.pop(context, {
                        "id": widget.item?["id"], // Maintain the existing ID
                        "name": _nameController.text.isNotEmpty
                            ? _nameController.text
                            : "No Name", // Provide a default name
                        "info": _infoController.text.isNotEmpty
                            ? _infoController.text
                            : "No Info", // Provide default info
                        "imagePath": widget.item?["imagePath"] ??
                            'assets/image/default.png', // Use existing or default image path
                        "status": widget.item?["status"] ??
                            "Unavailable", // Provide a default status
                        "color": (widget.item?["status"] == "Available"
                                ? Color(0xFF2EA64E)
                                : Color(0xFFFF0000)), // Default color if status is null
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                    ),
                    child: const Center(
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
