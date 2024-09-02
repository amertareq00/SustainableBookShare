import 'package:flutter/material.dart';
import 'package:sbs_prototype/widgets/CustomButton.dart';
import 'package:sbs_prototype/widgets/DropdownField.dart';

class FilterDialog extends StatelessWidget {
  final List<String> facultyNamesList;
  final List<String> bookConditionList;
  final List<String> typeBookNotebook;
  final bool isSwitched;
  final Function(bool) toggleSwitch;
  final VoidCallback applyFilter;

  const FilterDialog({
    required this.facultyNamesList,
    required this.bookConditionList,
    required this.typeBookNotebook,
    required this.isSwitched,
    required this.toggleSwitch,
    required this.applyFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF222831),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 350,
          height: 340,
          child: Column(
            children: [
              CustomDropdownMenu(
                options: facultyNamesList,
                hintText: "Faculty",
                prefixIcon: Icon(Icons.menu_book_rounded),
              ),
              CustomDropdownMenu(
                options: bookConditionList,
                hintText: "Condition",
                prefixIcon: Icon(Icons.menu_book_rounded),
              ),
              CustomDropdownMenu(
                options: typeBookNotebook,
                hintText: "Type",
                prefixIcon: Icon(Icons.menu_book_rounded),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                width: 300.0,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: const Text(
                        'Donated    ',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: toggleSwitch,
                      activeTrackColor: Color(0xFFEEEEEE),
                      activeColor: Color(0xFF76ABAE),
                    ),
                  ],
                ),
              ),
              CustomButton(
                buttonText: "Apply Filter",
                color: Color(0xFF76ABAE),
                onPressed: applyFilter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
