import 'package:flutter/material.dart';

class DropdownMenuUnitMeansure extends StatefulWidget {
  const DropdownMenuUnitMeansure({Key? key, required this.onSelected})
      : super(key: key);

  final void Function(String) onSelected;

  @override
  _DropdownMenuUnitMeansureState createState() =>
      _DropdownMenuUnitMeansureState();
}

class _DropdownMenuUnitMeansureState extends State<DropdownMenuUnitMeansure> {
  String selectedUnit = ''; // Inicialize como vazio

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: selectedUnit.isNotEmpty
          ? Text(selectedUnit)
          : const Text("Selecione uma Un. Medida"),
      value: selectedUnit.isNotEmpty ? selectedUnit : null,
      onChanged: (newValue) {
        setState(() {
          selectedUnit = newValue!;
          widget.onSelected(selectedUnit); // Chama a função de retorno de chamada
        });
      },
      items: const [
        DropdownMenuItem<String>(
          value: "KG",
          child: Text("Quilos"),
        ),
        DropdownMenuItem<String>(
          value: "G",
          child: Text("Gramas"),
        ),
        DropdownMenuItem<String>(
          value: "L",
          child: Text("Litros"),
        ),
        DropdownMenuItem<String>(
          value: "ML",
          child: Text("Mililitros"),
        ),
        DropdownMenuItem<String>(
          value: "UN",
          child: Text("Unidade"),
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
