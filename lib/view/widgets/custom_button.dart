import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class custom_button extends StatelessWidget {
  custom_button({
    super.key,
    required this.buttonBackGroundColor,
    required this.textButton,
    required this.functonOfButton,
  });
  Color? buttonBackGroundColor;
  String? textButton;
  Function? functonOfButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.sp,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            buttonBackGroundColor,
          ),
        ),
        onPressed: () {
          functonOfButton!();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            textButton!,
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        ),
      ),
    );
  }
}
