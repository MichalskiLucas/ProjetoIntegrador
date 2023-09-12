import 'package:flutter/material.dart';

class DropdownMenuIngredient extends StatefulWidget {
  const DropdownMenuIngredient({Key? key, required this.selectedIngredient})
      : super(key: key);

  final String selectedIngredient;

  @override
  _DropdownMenuIngredientState createState() =>
      _DropdownMenuIngredientState(selectedIngredient);
}

class _DropdownMenuIngredientState extends State<DropdownMenuIngredient> {
  String selectedIngredient;

  _DropdownMenuIngredientState(this.selectedIngredient);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: selectedIngredient.isNotEmpty
          ? Text(selectedIngredient)
          : const Text("Selecione um ingrediente"),
      value: selectedIngredient.isNotEmpty ? selectedIngredient : null,
      onChanged: (newValue) {
        setState(() {
          selectedIngredient = newValue!;
        });
      },
      items: const [
        DropdownMenuItem<String>(
          value: "Salada",
          child: Text("Salada"),
        ),
        DropdownMenuItem<String>(
          value: "Banana",
          child: Text("Banana"),
        ),
        DropdownMenuItem<String>(
          value: "Uva",
          child: Text("Uva"),
        ),
      ],
      iconSize: 24,
      isExpanded: true,
      underline: Container(
        height: 1,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
