import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitesDropdownMenuButton extends StatelessWidget {
  final String hint;
  final String hintSearch;
  final List<String> list;
  final String? selectedValue;
  final Function(String?) onChanged;
  final bool isSearchable; // Optional: Flag to enable search functionality

  const CitesDropdownMenuButton({
    Key? key,
    required this.hint,
    required this.hintSearch,
    required this.list,
    this.selectedValue,
    required this.onChanged,
    this.isSearchable = false, // Default to non-searchable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(hint),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      isExpanded: true, // Ensure the dropdown fills the available width
      value: selectedValue,
      items: list.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => onChanged(value),
      validator: (value) => value == null ? 'Please select a value' : null, // Basic validation
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: hintSearch,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
