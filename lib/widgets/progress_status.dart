import 'package:flutter/material.dart';

class ProgressStatus extends StatelessWidget {
  final String? status;

  ProgressStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    List<String> statuses = [
      'Received',
      'Under Repairing',
      'Repaired',
      'Delivered'
    ];

    int currentStep = statuses.indexOf(status ?? '');

    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.check_circle,
            color: currentStep >= 0 ? Color(0xFF76ABAE) : Colors.grey,
          ),
          title: Text(
            'Received',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: currentStep >= 0 ? Color(0xFF76ABAE) : Colors.grey,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check_circle,
            color: currentStep >= 1 ? Color(0xFF76ABAE) : Colors.grey,
          ),
          title: Text(
            'Under Repairing',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: currentStep >= 1 ? Color(0xFF76ABAE) : Colors.grey,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check_circle,
            color: currentStep >= 2 ? Color(0xFF76ABAE) : Colors.grey,
          ),
          title: Text(
            'Repaired',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: currentStep >= 2 ? Color(0xFF76ABAE) : Colors.grey,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check_circle,
            color: currentStep >= 3 ? Color(0xFF76ABAE) : Colors.grey,
          ),
          title: Text(
            'Delivered',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: currentStep >= 3 ? Color(0xFF76ABAE) : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
