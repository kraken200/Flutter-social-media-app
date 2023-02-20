import 'package:fitworld_app/screens/signup_screen.dart';
import 'package:fitworld_app/utils/colors.dart';
import 'package:fitworld_app/responsive/responsive_layout_screen.dart';
import 'package:fitworld_app/responsive/web_screen_layout.dart';
import 'package:fitworld_app/responsive/mobile_screen_layout.dart';
import 'package:fitworld_app/utils/utils.dart';
import 'package:fitworld_app/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:fitworld_app/resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout())));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(child: Container(), flex: 2),
            //image
            Image(
              image: AssetImage('assets/fit_world.png'),
              height: 64,
            ),
            const SizedBox(height: 64),
            //Email input
            TextFieldInput(
                textEditingController: _emailcontroller,
                hintText: 'Enter your Email',
                textInputType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            //password input
            TextFieldInput(
                textEditingController: _passwordcontroller,
                hintText: 'Enter your Password',
                isPass: true,
                textInputType: TextInputType.text),
            const SizedBox(height: 24),
            //button
            InkWell(
              onTap: loginUser,
              child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Log In'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      )),
                      color: blueColor)),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(child: Container(), flex: 2),
            //forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("Don't have an account? "),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
