import 'package:flutter/material.dart';

class DriverProfileScreen extends StatelessWidget {
  final Map<String, dynamic> driver;

  const DriverProfileScreen({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Профил на шофьор")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage(driver['photoUrl'])),
            SizedBox(height: 20),
            Text(driver['name'], style: TextStyle(fontSize: 24)),
            Text("Рейтинг: ${driver['rating']}/5", style: TextStyle(color: Colors.amber)),
            SizedBox(height: 20),
            ListTile(title: Text("Телефон: ${driver['phone']}")),
            ListTile(title: Text("Регистрационен номер: ${driver['vehicleNumber']}")),
          ],
        ),
      ),
    );
  }
}