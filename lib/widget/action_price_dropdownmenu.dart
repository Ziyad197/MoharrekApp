import 'package:flutter/material.dart';

class AuctionPriceDropDown extends StatelessWidget {
  const AuctionPriceDropDown({
    super.key,
    required this.onAuctionChanged,
    this.initialValue = '100', // Optional initial value
  }) : assert(onAuctionChanged != null); // Assert non-null onChanged callback

  final Function(String?) onAuctionChanged;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>( // Use DropdownButtonFormField for validation
      value: initialValue,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder( // Define error border (optional)
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        hintText:  ('أدخل المبلغ'),
        hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      validator: (value) { // Optional validation (e.g., check for number)
        if (value == null || value.isEmpty) {
          return 'Please enter a price.';
        }
        return null;
      },
      items: const [
        DropdownMenuItem(value: '100', child: Text('100 ر.س')),
        DropdownMenuItem(value: '500', child: Text('500 ر.س')),
        DropdownMenuItem(value: '1000', child: Text('1,000 ر.س')), // Use comma for thousands separator
      ],
      style: const TextStyle(fontSize: 14, color: Colors.black),
      icon: Container(
        padding: const EdgeInsets.all(10),
        child: const Text("ر.س", style: TextStyle(fontSize: 14, color: Colors.black)),
      ),
      onChanged: onAuctionChanged,
    );
  }
}
