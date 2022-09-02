import 'package:flutter/material.dart';


class SupportCenterCheckbox extends StatefulWidget {
  const SupportCenterCheckbox({Key? key}) : super(key: key);

  @override
  State<SupportCenterCheckbox> createState() => _SupportCenterCheckboxState();
}

class _SupportCenterCheckboxState extends State<SupportCenterCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
