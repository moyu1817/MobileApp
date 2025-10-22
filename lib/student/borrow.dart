import 'package:flutter/material.dart';

class Borrow extends StatefulWidget {
  const Borrow({super.key});

  @override
  State<Borrow> createState() => _BorrowState();
}

class _BorrowState extends State<Borrow> {
  String _startDate = '';
  String _endDate = '';

  void selectStartDate() async {
    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024, 12, 31),
    );

    if (dt != null) {
      setState(() {
        _startDate = '${dt.day}/${dt.month}/${dt.year}';
        // Reset end date if the start date is selected
        _endDate = '';
      });
    }
  }

  void selectEndDate() async {
    DateTime? startDate = DateTime.now();
    if (_startDate.isNotEmpty) {
      List<String> parts = _startDate.split('/');
      startDate = DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    }

    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: startDate, // Prevent selecting a date before the start date
      lastDate: DateTime(2024, 12, 31),
    );

    if (dt != null) {
      setState(() {
        _endDate = '${dt.day}/${dt.month}/${dt.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // กำหนดพื้นหลังเป็นสีขาว
      appBar: AppBar(
        title: const Center(
          child: Text(
            'SPORT APP',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(child: Image.asset('assets/images/football.png'),
              height: 250,
              width: 250,),
              
              const SizedBox(height: 10),
              Row(
                children: const [
                  Text(
                    'Football',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Text(
                    'Equipment status: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Available',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Info: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'A soccer ball is a round ball used in soccer, measuring 68-70 cm in circumference and weighing 410-450 grams. It\'s made of durable synthetic materials and is used for kicking, passing, and shooting in the game.',
                        style: const TextStyle(fontSize: 15),
                        //textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Date Selection Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start Date',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: selectStartDate,
                        child: SizedBox(
                          width: 180,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                _startDate.isEmpty ? 'Select Date' : _startDate,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'End Date',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: selectEndDate,
                        child: SizedBox(
                          width: 180,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                _endDate.isEmpty ? 'Select Date' : _endDate,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Borrow Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'BORROW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
