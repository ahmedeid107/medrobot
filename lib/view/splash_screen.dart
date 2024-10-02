import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medrobot_dradham/constants/colors.dart';

import 'package:medrobot_dradham/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationScale;
  late Animation<double> _animationOpacity;

  String? backendAppVerion;

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // الأنيميشن للانبثاق
    _animationScale = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    Timer(const Duration(seconds: 1), () {
      _controller.forward().then((_) {
        Timer(const Duration(seconds: 5), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
          ;
        });
      });
    });

    // الأنيميشن للظهور
    _animationOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // تأخير بدء الأنيميشن
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            left: -50, // يمكنك ضبط هذه القيمة لتحريك الدائرة يمينا ويسارا
            top: -50, // يمكنك ضبط هذه القيمة لتحريك الدائرة لأعلى ولأسفل
            child: Container(
              width: 150, // القطر الأفقي للدائرة
              height: 150, // القطر العمودي للدائرة
              decoration: BoxDecoration(
                color: bgThirdColor, // اللون الفاتح للدائرة
                shape: BoxShape.circle, // جعل الشكل دائري
              ),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: _animationScale,
              child: FadeTransition(
                opacity: _animationOpacity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CircleAvatar(
                            minRadius: 100,
                            maxRadius: 110,
                            child: Image.asset("assets/images/adham.jpg"),
                          ),
                        ),
                        Text(
                          "Dr. Adham Saleh",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Text(
                          "Med Robot team Founder",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            color: bgThirdColor,
                            fontSize: 20.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: Text(
                            "فَأَمَّا الزَّبَدُ فَيَذْهَبُ جُفَاءً وَأَمَّا مَا يَنْفَعُ النَّاسَ فَيَمْكُثُ فِي الْأَرْضِ كَذَلِكَ يَضْرِبُ اللَّهُ الْأَمْثَالَ",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: Text(
                            "كم أتمني ان أترك في وجدانكم أثرًا تتذكروني به يومًا من الأيام",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              color: bgThirdColor,
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ), // استبدل هذا بمسار شعارك
              ),
            ),
          ),
          Positioned(
            right: -50, // يمكنك ضبط هذه القيمة لتحريك الدائرة يمينا ويسارا
            bottom: -50, // يمكنك ضبط هذه القيمة لتحريك الدائرة لأعلى ولأسفل
            child: Container(
              width: 150, // القطر الأفقي للدائرة
              height: 150, // القطر العمودي للدائرة
              decoration: BoxDecoration(
                color: bgThirdColor, // اللون الفاتح للدائرة
                shape: BoxShape.circle, // جعل الشكل دائري
              ),
            ),
          ),
        ],
      ),
    );
  }
}
