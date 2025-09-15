import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/utils/search_controller.dart';

class SearchCustomField extends StatefulWidget {
  const SearchCustomField({
    Key? key,
    required this.onGetSearchValue,
    this.hintText,
    this.paddingTextfield,
    this.getSearchStatus,
    this.backgroundColor,
    this.hintStyle,
    this.hasBorder = false,
    this.textStyle,
    this.margin,
  }) : super(key: key);

  final EdgeInsets? paddingTextfield;
  final EdgeInsets? margin;
  final String? hintText;
  final void Function(String) onGetSearchValue;
  final void Function(bool)? getSearchStatus;
  final bool hasBorder;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  @override
  State<SearchCustomField> createState() => _SearchCustomFieldState();
}

class _SearchCustomFieldState extends State<SearchCustomField> {
  final controller = TextEditingController();
  late final _searchCtrl = SearchStreamController(
    onGetValue: widget.onGetSearchValue,
    updateSearchingStatus: widget.getSearchStatus,
  );

  @override
  void dispose() {
    controller.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _searchCtrl.searchStream,
      builder: (context, snapshot) => Container(
        margin: widget.margin,
        padding:
            widget.paddingTextfield ?? padding(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? appTheme.background,
          borderRadius: BorderRadius.circular(1000),
          border: widget.hasBorder
              ? Border.all(color: appTheme.borderColor)
              : Border(),
        ),
        child: TextField(
          controller: controller,
          onChanged: _searchCtrl.insertNewText,
          style: widget.textStyle ??
              TextStyle(
                color: appTheme.primaryTextColor,
                fontSize: 14.fontSize,
              ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: appTheme.fadeTextColor),
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                TextStyle(
                  color: appTheme.fadeTextColor,
                  fontSize: 14.fontSize,
                ),
          ),
        ),
      ),
    );
  }
}
