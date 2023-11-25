import 'package:bagzzz/auth/screens/login_screen.dart';
import 'package:bagzzz/core/widget/main_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
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
                        'Register',
                        style: TextStyle(
                          fontSize: 36.sp,
                        ),
                      ),
                      25.verticalSpace,
                      MainTextField(
                        width: .7.sw,
                        hint: 'Full Name',
                        fillColor: Colors.transparent,
                        label: 'Full Name',
                        controller: nameController,
                        validator: (text) {
                          if (text != null && text.length >= 3) {
                            return null;
                          } else {
                            return 'Please Add A Valid Name';
                          }
                        },
                      ),
                      10.verticalSpace,
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
                        height: .15.sh,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Already Member? ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                },
                                child: const Text(
                                  'Login',
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
                                onPressed: () async {
                                  if (isLoading == false) {
                                    if (formKey.currentState!.validate()) {
                                      //Register
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );

                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return const Scaffold(
                                            body: Center(
                                              child: Text('Home'),
                                            ),
                                          );
                                        }));
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if (e.code == 'weak-password') {
                                          print('The password provided is too weak.');
                                        } else if (e.code == 'email-already-in-use') {
                                          print('The account already exists for that email.');
                                        }
                                      } catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        print(e);
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  isLoading ? 'Loading...' : 'Register',
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
