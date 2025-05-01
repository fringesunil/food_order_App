import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/core/routes/routes_string.dart';
import 'package:food_order_app/screens/authendication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with CommonMethods {
  final GlobalKey<FormState> logInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, auth, child) {
        return Stack(
          children: [
            Container(
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.png'), fit: BoxFit.fill)),
            ),
            Center(
              child: Container(
                height: size.height * 0.60,
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Form(
                  key: logInKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextFormField(
                          controller: auth.emailController,
                          validator: auth.validator.emailValidator,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.email, color: Colors.amber),
                            hintText: 'Email Address',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.black26,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.amber),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofocus:
                              false, // Ensure autofocus is disabled if not needed
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: auth.passwordController,
                          validator: auth.validator.passwordValidator,
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.amber),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.black26,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.amber),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          autofocus:
                              false, // Ensure autofocus is disabled if not needed
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Container(
                        height: size.height * 0.07,
                        width: size.width * 0.60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.amber, Colors.orange],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (logInKey.currentState!.validate()) {
                              showLoaderButton(context);
                              auth.login(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'LOGIN',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 16),
                          children: [
                            TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                    color: Colors.red[400], fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    moveTo(context, AppRoutes.signup);
                                  }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
