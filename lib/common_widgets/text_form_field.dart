import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_task/common_widgets/field_decoration.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? fieldTitle;
  final String hintText;
  final String? initialVal;
  final String? Function(String?)? validator;
  final String Function(String)? onChanged;
  final Function()? onEditingComplete;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;

  final bool? readOnly;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;

  final bool? enabled;

  const CustomTextFormField(
      {super.key,
      this.controller,
      this.onEditingComplete,
      this.fieldTitle,
      this.enabled,
      required this.hintText,
      this.initialVal,
      this.validator,
      this.onChanged,
      this.onTap,
      this.suffixIcon,
      this.inputType,
      this.inputAction,
      this.focusNode,
      this.maxLines = 1,
      this.maxLength,
      this.autovalidateMode,
      this.inputFormatters,
      this.obscureText = false,
      this.readOnly = false});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.fieldTitle?.isNotEmpty ?? false)
          Container(
            margin: EdgeInsets.only(left: 4.sp, bottom: 4.sp, top: 6.sp),
            child: Text(
              widget.fieldTitle ?? "",
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled ?? true,
          maxLength: widget.maxLength,
          initialValue: widget.initialVal,
          readOnly: widget.readOnly ?? false,
          textCapitalization: TextCapitalization.sentences,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText ?? false,
          onChanged: widget.onChanged ??
              (val) {
                setState(() {});
              },
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
          onTap: widget.onTap,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          focusNode: widget.focusNode,
          autovalidateMode: widget.autovalidateMode,
          inputFormatters: widget.inputFormatters ?? [],
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.black,
          ),
          decoration: AppDecoration().fieldDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
