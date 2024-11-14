import 'package:flutter/material.dart';

class FilterTagWidget extends StatefulWidget {
  final String label;
  final IconData iconData;
  final void Function()? onPressed;
  final bool isEnergyTag;
  const FilterTagWidget(
      {super.key,
      required this.label,
      required this.iconData,
      required this.onPressed,
      this.isEnergyTag = true});

  @override
  State<FilterTagWidget> createState() => _FilterTagWidgetState();
}

class _FilterTagWidgetState extends State<FilterTagWidget> {
  bool _isActiveButton = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: _isActiveButton ? Colors.blue : null,
          side: const BorderSide(color: Colors.grey), // Cor do contorno
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Bordas arredondadas
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        onPressed: () {
          setState(() {
            _isActiveButton = !_isActiveButton; // Alterna o estado ao clicar
          });
          widget.onPressed!();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              // Icons.flash_on,
              widget.iconData, // Ícone de relâmpago
              color:
                  _isActiveButton ? Colors.white : Colors.grey, // Cor do ícone
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              // 'Sensor de Energia',
              widget.label,
              style: TextStyle(
                color: _isActiveButton
                    ? Colors.white
                    : Colors.grey, // Cor do texto
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
