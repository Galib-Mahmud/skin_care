import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class CheckinScreen1 extends StatefulWidget {
  @override
  _CheckinScreen1State createState() => _CheckinScreen1State();
}

class _CheckinScreen1State extends State<CheckinScreen1> {
  double waterIntake = 78.6;
  String mood = "Good";
  String skinStatus = "Clear";
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4EA), // Beige background matching the design
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Daily Check-in', style: TextStyle(color: Colors.black, fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood Section
            Text('How are you feeling today?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjusted for even spacing
              children: [
                _buildMoodButton('Struggling', '😞'),
                _buildMoodButton('Okay', '😕'),
                _buildMoodButton('Good', '😊'),
                _buildMoodButton('Great', '😄'),
                _buildMoodButton('Blessed', '🙏'),
              ],
            ),
            SizedBox(height: 20),

            // Skin Status Section
            Text('Skin Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSkinButton('Clear'),
                _buildSkinButton('Dry'),
                _buildSkinButton('Oily'),
                _buildSkinButton('Breakout'),
              ],
            ),
            SizedBox(height: 20),

            // Water Intake Section
            Text('Water Intake', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 12),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: waterIntake / 100,
                    strokeWidth: 8,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)), // Blue color from design
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Text('${waterIntake.toStringAsFixed(1)}%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    waterIntake += 8.0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Add 8 oz', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),

            // Notes Section
            Text('Today\'s Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'How is your skin feeling today? Any concerns or improvements?',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteName.checkinScreen2);

                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Save Check In', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFF7F4EA),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
      ),
    );
  }

  Widget _buildMoodButton(String moodLabel, String emoji) {
    return GestureDetector(
      onTap: () {
        setState(() {
          mood = moodLabel;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: mood == moodLabel ? Color(0xFF4A90E2) : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildSkinButton(String skinLabel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          skinStatus = skinLabel;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: skinStatus == skinLabel ? Color(0xFF4A90E2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          skinLabel,
          style: TextStyle(color: skinStatus == skinLabel ? Colors.white : Colors.black, fontSize: 14),
        ),
      ),
    );
  }
}