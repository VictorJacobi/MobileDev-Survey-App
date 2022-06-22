import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPage extends StatefulWidget {
  final String image;
  final String headingText;
  final String labelingText;
  const ViewPage(this.image,this.labelingText,this.headingText, {Key? key}) : super(key: key);


  @override
  _ViewPageState createState() => _ViewPageState();
}


class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 340.h,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 280.h,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 70.h,),
        Column(
          children: [
            Text(
              widget.headingText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF222525),
              ),
            ),
            const SizedBox(height: 8,),
            SizedBox(
              width: 280.w,
              child: Text(
                widget.labelingText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF525257),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
