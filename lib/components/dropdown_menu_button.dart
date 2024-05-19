import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenuButton extends StatefulWidget {
  final String hint;
  final String hintSearch;
  final List<String> list;
  final Function onChanged;
  String? selectedValue;
  CustomDropdownMenuButton(
      {super.key,
      required this.hint,
      required this.list,
      required this.onChanged,
      this.selectedValue,
      required this.hintSearch});

  @override
  State<CustomDropdownMenuButton> createState() =>
      _CustomDropdownMenuButtonState();
}

class _CustomDropdownMenuButtonState extends State<CustomDropdownMenuButton> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      validator: (value) {
        if (value == null) {
          return "رجاء اختر من القائمة";
        }
      },
      decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorStyle: TextStyle(height: 0.1)),
      isExpanded: true,
      hint: Row(
        children: [
          Expanded(
            child: Text(
              widget.hint,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: widget.list
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),

      value:
      widget.selectedValue,
      onChanged: (value) {
        widget.onChanged(value);
      },
      buttonStyleData: ButtonStyleData(
        height: 50,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.blue,
          ),
          color: Colors.white,
        ),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_sharp,
        ),
        iconSize: 26,
        iconEnabledColor: Colors.blue,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
      dropdownSearchData: DropdownSearchData(
        searchController: textEditingController,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: widget.hintSearch,
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return item.value.toString().toLowerCase().contains(searchValue);
        },
      ),
      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          textEditingController.clear();
        }
      },
    );
  }
}
