import 'package:flutter/material.dart';
import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:get/get.dart';

List<String> name = ['Airtel', 'Jio', 'Vi'];
List<String> path = [
  'assets/images/airtel_logo.png',
  'assets/images/jio_logo.png',
  'assets/images/vi_logo.png'
];

Future<void> simUpdate(BuildContext context,deviceid) async {
  String selectedNetwork = ''; // Track selected network
  int selectedIndex = -1; // Track selected index

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: SizedBox(
            height: 100,
            width: 100,
            child: GridView.builder(
              itemCount: 3,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Select(
                  index: index,
                  logoPath: path[index],
                  isSelected: selectedIndex == index, // Check if selected
                  onSelect: () {
                    setState(() {
                      selectedIndex = index; // Update selected index
                      selectedNetwork = name[index]; // Update selected network
                    });
                  },
                );
              },
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel'.tr,
                style: CustomTextStyles.titleLargeRedA70002,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle confirm action here
               updatesim(deviceid, context, selectedIndex+1);
              },
              child: Text(
                'Confirm'.tr,
                style: CustomTextStyles.bodyLargeDMSansBluegray500,
              ),
            ),
          ],
        );
      },
    ),
  );
}

// Updated Select widget to accept selected state and handle tap
class Select extends StatelessWidget {
  final String logoPath;
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;

  Select({
    required this.logoPath,
    required this.index,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onSelect, // Call the onSelect function when tapped
        child: Container(
          width: 66,
          height: 80,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white, // Background remains white
            border: Border.all(
              color: isSelected ? Colors.green : Colors.white, // Green border if selected
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Image.asset(
                logoPath,
                height: 40,
                width: 50,
                fit: BoxFit.contain,
              ), // Network logo
            ],
          ),
        ),
      ),
    );
  }
}
