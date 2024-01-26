import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final String? category;
  const CategoryDropdown({super.key, this.category});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late String _selectedItem;
  List<String> categories = ['Email', 'Finance', 'Social Media', 'Entertainment', 'Cancel'];

  @override
  void initState() {
    super.initState();
    if (widget.category != null ){
      if(categories.contains(widget.category)){
        _selectedItem = widget.category!;
      }else{
        print("unknown category");
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
      hint: Text('Category'),
      onChanged: (String? newValue) {
        setState(() {
          if(newValue == 'Cancel'){
            _selectedItem = '';
          }else{
            _selectedItem = newValue ?? '';
          }
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
