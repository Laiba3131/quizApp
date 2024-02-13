import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback? tap;
  final double? paddingVertical;
  final double? paddingHorizontal;
  const CustomButton({
    super.key,
    required this.buttonTitle,
    required this.tap,
    this.paddingVertical = 9,
    this.paddingHorizontal = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: tap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            vertical: paddingVertical!.sp, horizontal: paddingHorizontal!.sp)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        backgroundColor: MaterialStateProperty.all(Colors.amber),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonTitle,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
