import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids/features/todo/presentation/manger/add_todo_cubit/add_todo_cubit.dart';


class MYCheckbox extends StatefulWidget {
  const MYCheckbox({super.key});

  @override
  State<MYCheckbox> createState() => _MYCheckboxState();
}

class _MYCheckboxState extends State<MYCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Color getColor(Set<MaterialState> states) {
    //   const Set<MaterialState> interactiveStates = <MaterialState>{
    //     MaterialState.pressed,
    //     MaterialState.hovered,
    //     MaterialState.focused,
    //   };
    //   if (states.any(interactiveStates.contains)) {
    //     return Colors.blue;
    //   }
    //   return Colors.red;
    // }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Complete"),
        Checkbox(
          // checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              context.read<AddTodoCubit>().isComplete=value!;
              // print(value);
              isChecked = value!;
              // print(isChecked);

            });
          },
        ),
      ],
    );
  }
}