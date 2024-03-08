import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final String? category;
  final void Function(String) onCategoryChanged;
  const CategoryDropdown({super.key, this.category, required this.onCategoryChanged});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late String _selectedItem;
  List<String> categories = ['Email', 'Entertainment', 'Finance', 'Shopping', 'Social Media', 'Password Manager', 'Physical Device', 'Cancel'];

  @override
  void initState() {
    super.initState();
    if (widget.category != null ){
      if(categories.contains(widget.category)){
        _selectedItem = widget.category!;
      }else{
        _selectedItem = '';
      }
    }else{
      _selectedItem = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedItem.isNotEmpty ? _selectedItem : null,
      underline: Container(
        height: 2,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
      ),
      iconSize: 0,
      hint: const Text('Category'),
      onChanged: (String? newValue) {
        setState(() {
          if(newValue == 'Cancel'){
            _selectedItem = '';
          }else{
            _selectedItem = newValue ?? '';
          }
          widget.onCategoryChanged(_selectedItem);
        });
      },
      items: categories.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }


}
