import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType? textInputType;
  final VoidCallback? onTap;

  const TextFieldWidget({
    super.key,
    required this.text,
    this.textEditingController,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.onTap,
    this.textInputType
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _isFocused ? Colors.lightBlue.shade50 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            inputFormatters: [],
            keyboardType: widget.textInputType,
            onTap: widget.onTap,
            // readOnly: widget.readOnly,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            controller: widget.textEditingController,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              hintText: widget.text,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade400,
              ),
              prefixIcon: widget.prefixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1.5.w),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
