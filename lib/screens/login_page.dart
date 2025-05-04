import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_ecommerce/screens/bottom_nav_bar_page.dart';
import 'package:project_ecommerce/widgets/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordObscure = true;
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/loginimage.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LifeStyleZ',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.yellow,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16),
                SizedBox(
                    height: 55,
                    child: TextFieldWidget(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      Text: 'username',
                      prefixIcon: Icons.email,
                      fillColor: Colors.transparent,
                      hintTextColor: Colors.yellow,
                    )),
                const SizedBox(height: 16),
                TextFieldWidget(fillColor: Colors.transparent,
                  obscureText: isPasswordObscure,
                  Text: 'Password',hintTextColor: Colors.yellow,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordObscure = !isPasswordObscure;
                      });
                    },
                    icon: Icon(
                        isPasswordObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgotten Password',
                      style: TextStyle(
                          fontSize: 14, color: Colors.yellow.shade200),
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 410,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor:
                              Colors.transparent // Set the button color
                          ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBarPage(),));
                      },
                      child:  Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 110),
                  child: Row(
                    children: [
                      Icon(
                        Icons.g_mobiledata,
                        color: Colors.red,
                      ),
                      TextButton(
                        onPressed: () async {
                          UserCredential? user = await signInWithGoogle();
                          if (user != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBarPage(),
                                ));
                          }
                        },
                        child: Text(
                          'Log in with Google',
                          style: TextStyle(
                              fontSize: 16, color: Colors.yellow.shade400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
