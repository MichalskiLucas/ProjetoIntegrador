import 'package:flutter/material.dart';

class DropdownMenuIngredient extends StatefulWidget {
  const DropdownMenuIngredient({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final void Function(String) onSelected;

  @override
  _DropdownMenuIngredientState createState() => _DropdownMenuIngredientState();
}

class _DropdownMenuIngredientState extends State<DropdownMenuIngredient> {
  String selectedIngredient = ''; // Inicialize como vazio

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: selectedIngredient.isNotEmpty
          ? Text(selectedIngredient)
          : const Text("Selecione um Ingrediente"),
      value: selectedIngredient.isNotEmpty ? selectedIngredient : null,
      onChanged: (newValue) {
        setState(() {
          selectedIngredient = newValue!;
          widget.onSelected(selectedIngredient);
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
