import 'package:bagzzz/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/widget/main_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/images/login.svg',
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.brown.shade200, BlendMode.srcATop),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.sp),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: SizedBox(
                  height: 1.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 36.sp,
                        ),
                      ),
                      25.verticalSpace,
                      MainTextField(
                        width: .7.sw,
                        hint: 'example@email.com',
                        fillColor: Colors.transparent,
                        label: 'E-mail',
                        controller: emailController,
                        validator: (text) {
                          if (text != null && text.length >= 3) {
                            return null;
                          } else {
                            return 'Please Add A Valid Email';
                          }
                        },
                      ),
                      10.verticalSpace,
                      MainTextField(
                        width: .7.sw,
                        hint: '********',
                        fillColor: Colors.transparent,
                        label: 'Password',
                        controller: passwordController,
                        validator: (text) {
                          if (text != null && text.length >= 8) {
                            return null;
                          } else {
                            return 'Please Add A Valid Password';
                          }
                        },
                      ),
                      75.verticalSpace,
                      SizedBox(
                        height: .2.sh,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'New Member? ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                )),
                            const Spacer(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  fixedSize: Size(.3.sw, .06.sh),
                                  side: const BorderSide(color: Colors.white),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      10.verticalSpace
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
